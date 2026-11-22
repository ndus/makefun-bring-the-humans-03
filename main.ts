// Validate and hand the entry's VIDEO.json to the competition runner.
const fs = require('node:fs');
const path = require('node:path');

const repository = process.env.MAKEFUN_BOT_DIR || process.cwd();
const output = process.env.MAKEFUN_OUTPUT_DIR || './out';
const videoFile = path.join(repository, 'VIDEO.json');
const outputFile = path.join(output, 'VIDEO.json');

try {
  const video = JSON.parse(fs.readFileSync(videoFile, 'utf8'));
  if (!video || typeof video.url !== 'string' || video.url.length === 0) {
    throw new Error('VIDEO.json must contain a non-empty string field named "url"');
  }

  fs.mkdirSync(output, { recursive: true });
  fs.copyFileSync(videoFile, outputFile);
} catch (error) {
  console.error(`Unable to hand in VIDEO.json: ${error.message}`);
  process.exitCode = 1;
}

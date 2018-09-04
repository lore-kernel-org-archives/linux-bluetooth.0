Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tanu Kaskinen <tanuk@iki.fi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH][sbc] sbc: fix frame_length and codesize documentation
Date: Tue,  4 Sep 2018 19:29:55 +0300
Message-Id: <20180904162955.28855-1-tanuk@iki.fi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

frame_length is the output block size when encoding and the input block
size when decoding, with codesize it's vice versa. The documentation was
inaccurate regarding this. Using the terms "compressed" and
"uncompressed" instead of "output" and "input" should make the function
semantics clear.
---
 sbc/sbc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sbc/sbc.h b/sbc/sbc.h
index d6f123e..835460a 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -100,13 +100,13 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 			void *output, size_t output_len, ssize_t *written);
 
-/* Returns the output block size in bytes */
+/* Returns the compressed block size in bytes */
 size_t sbc_get_frame_length(sbc_t *sbc);
 
 /* Returns the time one input/output block takes to play in msec*/
 unsigned sbc_get_frame_duration(sbc_t *sbc);
 
-/* Returns the input block size in bytes */
+/* Returns the uncompressed block size in bytes */
 size_t sbc_get_codesize(sbc_t *sbc);
 
 const char *sbc_get_implementation_info(sbc_t *sbc);
-- 
2.18.0

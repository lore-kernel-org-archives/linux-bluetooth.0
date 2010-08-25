Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 10:49:33 +0200
From: Colin Didier <didier@archos.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix left overs handling in bluetooth_a2dp_write() of
 audio/pcm_bluetooth.c
Message-ID: <20100825084932.GA27072@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

If for some reason there is not enough data provided to the function
bluetooth_a2dp_write() and there are left overs to handle, the ALSA
module will segfault.

The test at the line 1053 of audio/pcm_bluetooth.c is wrong because it
compares unsigned integers and will lead to an unsigned integer overflow
if bytes_left is inferior to a2dp->codesize - data->count.

Here is a patch to fix this issue.

Cheers,
  Colin DIDIER


--- a/audio/pcm_bluetooth.c	2010-08-25 09:35:28.000000000 +0200
+++ b/audio/pcm_bluetooth.c	2010-08-25 09:37:47.000000000 +0200
@@ -1050,8 +1050,10 @@
 	}
 
 	/* Check if we have any left over data from the last write */
-	if (data->count > 0 && (bytes_left - data->count) >= a2dp->codesize) {
-		int additional_bytes_needed = a2dp->codesize - data->count;
+        if (data->count > 0) {
+                int additional_bytes_needed = a2dp->codesize - data->count;
+                if (additional_bytes_needed > bytes_left)
+                        goto out;
 
 		memcpy(data->buffer + data->count, buff,
 						additional_bytes_needed);
@@ -1122,6 +1124,7 @@
 		}
 	}
 
+out:
 	/* Copy the extra to our temp buffer for the next write */
 	if (bytes_left > 0) {
 		memcpy(data->buffer + data->count, buff, bytes_left);

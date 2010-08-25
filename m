Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 15:06:07 +0200
From: Colin Didier <didier@archos.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix leftovers handling
Message-ID: <20100825130607.GA7199@cybione.org>
References: <20100825084932.GA27072@cybione.org>
 <20100825112636.GA23943@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100825112636.GA23943@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If for some reason there is not enough data provided to the function
bluetooth_a2dp_write() and there are leftovers to handle, the ALSA
module will segfault.
---
 audio/pcm_bluetooth.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 4c0ab6f..ff463fe 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1050,8 +1050,11 @@ static snd_pcm_sframes_t bluetooth_a2dp_write(snd_pcm_ioplug_t *io,
 	}
 
 	/* Check if we have any left over data from the last write */
-	if (data->count > 0 && (bytes_left - data->count) >= a2dp->codesize) {
-		int additional_bytes_needed = a2dp->codesize - data->count;
+	if (data->count > 0) {
+		unsigned int additional_bytes_needed =
+						a2dp->codesize - data->count;
+		if (additional_bytes_needed > bytes_left)
+			goto out;
 
 		memcpy(data->buffer + data->count, buff,
 						additional_bytes_needed);
@@ -1122,6 +1125,7 @@ static snd_pcm_sframes_t bluetooth_a2dp_write(snd_pcm_ioplug_t *io,
 		}
 	}
 
+out:
 	/* Copy the extra to our temp buffer for the next write */
 	if (bytes_left > 0) {
 		memcpy(data->buffer + data->count, buff, bytes_left);
-- 
1.7.1


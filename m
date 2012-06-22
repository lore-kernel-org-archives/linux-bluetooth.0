Return-Path: <cyrus@holtmann.org>
Message-ID: <4FE44DAD.90004@ruff.mobi>
Date: Fri, 22 Jun 2012 12:49:17 +0200
From: "Ruslan N. Marchenko" <me@ruff.mobi>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] pcm_bluetooth: accept BT_A2DP_SBC_SOURCE codec
Content-Type: multipart/mixed;
 boundary="------------030100030503050905010904"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030100030503050905010904
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Current implementation of the PCM code is considering capture (source) 
mode however it ignores codecs of the SBC_SOURCE type while parsing 
capabilities.
With these two lines source codec is accepted, although proper capture 
mode might require additional changes.

Signed-off-by: Ruslan N. Marchenko <me@ruff.mobi>
---
  audio/pcm_bluetooth.c |    4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)



--------------030100030503050905010904
Content-Type: text/x-patch;
 name="0001-pcm_bluetooth-accept-BT_A2DP_SBC_SOURCE-codec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-pcm_bluetooth-accept-BT_A2DP_SBC_SOURCE-codec.patch"

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index b9da805..5d69e2f 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -1630,8 +1630,10 @@ static int bluetooth_parse_capabilities(struct bluetooth_data *data,
 		return 0;
 
 	while (bytes_left > 0) {
-		if ((codec->type == BT_A2DP_SBC_SINK) &&
+		if (((codec->type == BT_A2DP_SBC_SINK) &&
 				!(codec->lock & BT_WRITE_LOCK))
+		|| ((codec->type == BT_A2DP_SBC_SOURCE) &&
+				!(codec->lock & BT_READ_LOCK)))
 			break;
 
 		bytes_left -= codec->length;


--------------030100030503050905010904--

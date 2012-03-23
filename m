Return-Path: <cyrus@holtmann.org>
From: Mike Brudevold <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Brudevold <michael.brudevold@logicpd.com>
Subject: [PATCH] avdtp: fix audio source init check
Date: Fri, 23 Mar 2012 10:03:47 -0500
Message-Id: <1332515027-31529-1-git-send-email-puffy.taco@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michael Brudevold <michael.brudevold@logicpd.com>

---
 audio/avdtp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index cd66fd4..8b36f0b 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1520,7 +1520,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	case AVDTP_SEP_TYPE_SINK:
 		if (!dev->source) {
 			btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
-			if (!dev->sink) {
+			if (!dev->source) {
 				error("Unable to get a audio source object");
 				err = AVDTP_BAD_STATE;
 				goto failed;
-- 
1.7.5.4


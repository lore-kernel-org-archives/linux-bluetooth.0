Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio: Fix media transport creation
Date: Mon, 21 May 2012 17:31:27 +0200
Message-Id: <1337614287-28938-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prevents set_configuration() to be called on another adapter
than connecting one
---
 audio/media.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/audio/media.c b/audio/media.c
index 427087a..8b29ac7 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -491,6 +491,9 @@ static void headset_state_changed(struct audio_device *dev,
 		}
 		break;
 	case HEADSET_STATE_CONNECTING:
+		if (bacmp(&endpoint->adapter->src, &dev->src) != 0)
+			break;
+
 		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
 								dev, NULL);
 		break;
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/7] Add missing call to headset_remove_state_cb
Date: Fri, 12 Aug 2011 17:27:51 +0200
Message-Id: <1313162877-14945-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 18e873e..f61ef0f 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -702,6 +702,9 @@ void audio_device_unregister(struct audio_device *device)
 {
 	unix_device_removed(device);
 
+	if (headset_callback_id != 0)
+		headset_remove_state_cb(headset_callback_id);
+
 	if (device->hs_preauth_id) {
 		g_source_remove(device->hs_preauth_id);
 		device->hs_preauth_id = 0;
-- 
1.7.1


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/13] audio: Append version to Control interface
Date: Fri, 14 Dec 2012 11:12:56 +0200
Message-Id: <1355476387-2165-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/control-api.txt      | 2 +-
 profiles/audio/control.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index 55cebe8..5fc8991 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -9,7 +9,7 @@ Control hierarchy
 =================
 
 Service		org.bluez
-Interface	org.bluez.Control
+Interface	org.bluez.Control1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		void Play()
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 800a151..878dd1e 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -22,7 +22,7 @@
  *
  */
 
-#define AUDIO_CONTROL_INTERFACE "org.bluez.Control"
+#define AUDIO_CONTROL_INTERFACE "org.bluez.Control1"
 
 struct control *control_init(struct audio_device *dev, GSList *uuids);
 void control_update(struct control *control, GSList *uuids);
-- 
1.7.11.7


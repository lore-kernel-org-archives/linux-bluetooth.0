Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Add support for 3rd party Memorex Wiimote
Date: Wed, 21 Dec 2011 14:13:48 +0100
Message-Id: <1324473228-9482-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The 3rd party Memorex Wiimote is compatible with the normal wiimote but uses
different VID/PID values.
If we add more combinations we probably need some lookup-table, but for now this
seems ok.
---
 plugins/wiimote.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index fead72a..45e5729 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -53,6 +53,10 @@
  * to the input service, then auto-reconnect is not enabled.
  * If enabled, the wiimote connects to the host automatically when any button
  * is pressed.
+ *
+ * Knwon VID/PID combinations:
+ *  - 057e:0306 Official Nintendo Wii Remotes
+ *  - 054c:0306 Memorex Wii Remotes (3rd party)
  */
 
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
@@ -67,7 +71,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 	ba2str(&dba, addr);
 
 	vendor = btd_device_get_vendor(device);
-	if (vendor != 0x057e)
+	if (vendor != 0x057e && vendor != 0x054c)
 		return 0;
 
 	product = btd_device_get_product(device);
-- 
1.7.8


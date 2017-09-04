Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] autopair: Don't handle the iCade
Date: Mon,  4 Sep 2017 19:54:46 +0200
Message-Id: <20170904175446.4798-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can't easily enter digits other than 1 through 4 (inclusive)
so leave it up to the agent to figure out a good passcode
for the iCade.

Note that we can not use the VID/PID of the device, as it is not
yet known at that point.
---
 plugins/autopair.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index d44cf539b..a9d2a930a 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -60,13 +60,24 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 {
 	char addr[18];
 	char pinstr[7];
+	char name[25];
 	uint32_t class;
 
 	ba2str(device_get_address(device), addr);
 
 	class = btd_device_get_class(device);
 
-	DBG("device %s 0x%x", addr, class);
+	device_get_name(device, name, sizeof(name));
+	name[sizeof(name) - 1] = 0;
+
+	DBG("device '%s' (%s) class: 0x%x vid/pid: 0x%X/0x%X",
+		name, addr, class,
+		btd_device_get_vendor (device),
+		btd_device_get_product (device));
+
+	/* The iCade shouldn't use random PINs like normal keyboards */
+	if (name != NULL && strstr(name, "iCade") != NULL)
+		return 0;
 
 	/* This is a class-based pincode guesser. Ignore devices with an
 	 * unknown class.
-- 
2.14.1


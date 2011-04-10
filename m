Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Remove unnecessary code from pin handler
Date: Sun, 10 Apr 2011 17:48:11 +0200
Message-Id: <1302450491-26550-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The source address is not used inside the pin handler and, thus,
can be skipped.
---
 src/event.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/event.c b/src/event.c
index 4ca1be5..5373e33 100644
--- a/src/event.c
+++ b/src/event.c
@@ -105,7 +105,7 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 				const char *pincode, struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	bdaddr_t sba, dba;
+	bdaddr_t dba;
 	int err;
 
 	device_get_address(device, &dba);
@@ -121,8 +121,6 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 	if (err < 0)
 		goto fail;
 
-	adapter_get_address(adapter, &sba);
-
 	return;
 
 fail:
-- 
1.7.4.4


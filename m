Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Fix wiimote device_get_address to use new API
Date: Thu, 29 Dec 2011 17:59:44 +0100
Message-Id: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit b06899eace1f484b387aae0e568fb1da988b468c introduced a new API for
device_get_name but apparently missed fixing the call in plugins/wiimote.c. This
patch converts the plugin to use the new API.
---
 plugins/wiimote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index fead72a..1ae638b 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -63,7 +63,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 	char addr[18];
 
 	adapter_get_address(adapter, &sba);
-	device_get_address(device, &dba);
+	device_get_address(device, &dba, NULL);
 	ba2str(&dba, addr);
 
 	vendor = btd_device_get_vendor(device);
-- 
1.7.8.1


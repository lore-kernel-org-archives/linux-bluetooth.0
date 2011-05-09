Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Fix a crash when creating a device from storage
Date: Mon,  9 May 2011 14:55:44 -0300
Message-Id: <1304963744-31282-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The list "services" is just a list of the object paths of the
registered services that a device has. When we want to store
the primary services information we need to store the "primaries"
list, that contain all the primary services information.
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index b0a6542..9b8591b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1567,7 +1567,7 @@ static void store_services(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
 	bdaddr_t dba, sba;
-	char *str = primary_list_to_string(device->services);
+	char *str = primary_list_to_string(device->primaries);
 
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
-- 
1.7.4.3


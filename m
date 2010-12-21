Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 09/18] Remove GATT information when the device is removed
Date: Tue, 21 Dec 2010 19:26:31 -0200
Message-Id: <1292966800-6264-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a way to remove the information about the device type and its
primary services when the device is going to be removed from the permanent
storage.
---
 src/device.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 627db8f..f123288 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1024,6 +1024,8 @@ static void device_remove_stored(struct btd_device *device)
 		device_remove_bonding(device);
 	delete_entry(&src, "profiles", addr);
 	delete_entry(&src, "trusts", addr);
+	delete_entry(&src, "types", addr);
+	delete_entry(&src, "primary", addr);
 	delete_all_records(&src, &device->bdaddr);
 	delete_device_service(&src, &device->bdaddr);
 
-- 
1.7.3.4


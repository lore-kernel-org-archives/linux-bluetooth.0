Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Remove leftover code of primary service storage
Date: Tue, 11 Oct 2011 15:47:36 -0300
Message-Id: <1318358856-11962-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318358856-11962-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318358856-11962-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Primary services related to a given address is already being removed
in delete_device_service() function.
---
 src/device.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 202bb3f..b7e343b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1087,7 +1087,6 @@ static void device_remove_stored(struct btd_device *device)
 	}
 	delete_entry(&src, "profiles", addr);
 	delete_entry(&src, "trusts", addr);
-	delete_entry(&src, "primary", addr);
 	delete_all_records(&src, &device->bdaddr);
 	delete_device_service(&src, &device->bdaddr);
 
-- 
1.7.7


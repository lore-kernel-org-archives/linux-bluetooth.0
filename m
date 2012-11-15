Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] adapter: Set device class in device object
Date: Thu, 15 Nov 2012 18:31:38 +0100
Message-Id: <1353000701-16605-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move storage of device class after device object creation.
---
 src/adapter.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5157b46..9ecc0fa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3070,9 +3070,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
-	if (eir_data.class != 0)
-		write_remote_class(&adapter->bdaddr, bdaddr, eir_data.class);
-
 	if (eir_data.appearance != 0)
 		write_remote_appearance(&adapter->bdaddr, bdaddr, bdaddr_type,
 							eir_data.appearance);
@@ -3102,6 +3099,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	if (eir_data.name)
 		device_set_name(dev, eir_data.name);
 
+	if (eir_data.class != 0)
+		device_set_class(dev, eir_data.class);
+
 	device_add_eir_uuids(dev, eir_data.services);
 
 	eir_data_free(&eir_data);
-- 
1.7.9.5


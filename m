Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] neard: Set device class in device object
Date: Thu, 15 Nov 2012 18:31:41 +0100
Message-Id: <1353000701-16605-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will create a new device object and generate
DeviceCreated signal
---
 plugins/neard.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 8f8381c..069953a 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -287,10 +287,11 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 	if (device)
 		adapter_remove_device(adapter, device, TRUE);
 
+	device = adapter_get_device(adapter, remote_address);
+
 	/* store OOB data */
 	if (eir_data.class != 0)
-		write_remote_class(adapter_get_address(adapter),
-					&eir_data.addr, eir_data.class);
+		device_set_class(device, eir_data.class);
 
 	/* TODO handle incomplete name? */
 	if (eir_data.name)
-- 
1.7.9.5


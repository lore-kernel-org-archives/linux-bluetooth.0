Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Remove OOB data if device was discovered in band
Date: Tue, 20 Nov 2012 11:38:54 +0100
Message-ID: <1353407934-17831-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OOB authentication mechanism should be used only if pairing process
has been activated by previous OOB information exchange (Core Spec
4.0 , vol. 1, Part A, 5.1.4.3). Stored OOB data for specific device
should be removed if that device was discovered in band later on.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
V2:
Move OOB data removal to hci_inquiry_cache_update to cover all inquiry
events (ext/rssi) in one place.

 net/bluetooth/hci_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3a49db..81f4bac 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -434,6 +434,8 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
 
+	hci_remove_remote_oob_data(hdev, &data->bdaddr);
+
 	if (ssp)
 		*ssp = data->ssp_mode;
 
-- 
1.7.9.5


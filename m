Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: AMP: Do not set name for AMP ctrl
Date: Wed,  6 Jun 2012 18:00:56 +0300
Message-Id: <1338994856-31200-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP controllers do not understand this command

...
< HCI Command: Write Local Name (0x03|0x0013) plen 248
   name ''
> HCI Event: Command Complete (0x0e) plen 4
   Write Local Name (0x03|0x0013) ncmd 1
   status 0x01
   Error: Unknown HCI Command
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..9afcc84 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2135,6 +2135,9 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	if (hdev->amp_type != HCI_BREDR)
+		return -ENOTSUPP;
+
 	hci_dev_lock(hdev);
 
 	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
-- 
1.7.9.5


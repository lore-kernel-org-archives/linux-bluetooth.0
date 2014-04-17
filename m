Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Return EOPNOTSUPP for HCISETRAW ioctl command
Date: Wed, 16 Apr 2014 20:04:38 -0700
Message-Id: <1397703878-44875-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCISETRAW ioctl command is not really useful. To utilize raw and
direct access to the HCI controller, the HCI User Channel feature has
been introduced. Return EOPNOTSUPP to indicate missing support for
this command.

For legacy reasons hcidump used to use HCISETRAW for permission check
to return proper error codes to users. To keep backwards compability
return EPERM in case the caller does not have CAP_NET_ADMIN capability.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b9a418e578e0..f608bffdb8b9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -524,16 +524,7 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	case HCISETRAW:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-
-		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-			return -EPERM;
-
-		if (arg)
-			set_bit(HCI_RAW, &hdev->flags);
-		else
-			clear_bit(HCI_RAW, &hdev->flags);
-
-		return 0;
+		return -EOPNOTSUPP;
 
 	case HCIGETCONNINFO:
 		return hci_get_conn_info(hdev, (void __user *) arg);
-- 
1.9.0


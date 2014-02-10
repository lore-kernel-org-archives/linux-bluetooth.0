Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gianluca Anzolin <gianluca@sottospazio.it>,
	Alexander Holler <holler@ahsoftware.de>,
	Andrey Vihrov <andrey.vihrov@gmail.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 16/24] Bluetooth: Fix RFCOMM parent device for reused dlc
Date: Sun,  9 Feb 2014 20:59:16 -0500
Message-Id: <1391997564-1805-17-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The RFCOMM tty device is parented to the acl link device when
the dlc state_change(BT_CONNECTED) notification is received.
However, if the dlc from the RFCOMM socket is being reused
(RFCOMM_REUSE_DLC is set), then the dlc may already be connected,
and no notification will occur.

Instead, always parent the RFCOMM tty device to the acl link
device at registration time. If the acl link device is not available
(eg, because the dlc is not connected) then the tty will remain
unparented until the BT_CONNECTED notification is received.

Fixes regression with ModemManager when the rfcomm device is
created with the flag RFCOMM_REUSE_DLC.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 2975bc4..fa1226f 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -316,6 +316,7 @@ out:
 		goto free;
 	}
 
+	rfcomm_reparent_device(dev);
 	dev_set_drvdata(dev->tty_dev, dev);
 
 	if (device_create_file(dev->tty_dev, &dev_attr_address) < 0)
-- 
1.8.1.2

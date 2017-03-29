Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable <stable@vger.kernel.org>,
	Frederic Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] Bluetooth: hci_bcm: add missing tty-device sanity check
Date: Wed, 29 Mar 2017 18:15:27 +0200
Message-Id: <20170329161528.17843-2-johan@kernel.org>
In-Reply-To: <20170329161528.17843-1-johan@kernel.org>
References: <20170329161528.17843-1-johan@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure to check the tty-device pointer before looking up the sibling
platform device to avoid dereferencing a NULL-pointer when the tty is
one end of a Unix98 pty.

Fixes: 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM devices")
Cc: stable <stable@vger.kernel.org>     # 4.3
Cc: Frederic Danis <frederic.danis@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5262a2077d7a..11f30e5cec2c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -287,6 +287,9 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
+	if (!hu->tty->dev)
+		goto out;
+
 	mutex_lock(&bcm_device_lock);
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
@@ -307,7 +310,7 @@ static int bcm_open(struct hci_uart *hu)
 	}
 
 	mutex_unlock(&bcm_device_lock);
-
+out:
 	return 0;
 }
 
-- 
2.12.2

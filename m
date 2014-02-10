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
Subject: [PATCH 08/24] Bluetooth: Fix unreleased rfcomm_dev reference
Date: Sun,  9 Feb 2014 20:59:08 -0500
Message-Id: <1391997564-1805-9-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When RFCOMM_RELEASE_ONHUP is set, the rfcomm tty driver 'takes over'
the initial rfcomm_dev reference created by the RFCOMMCREATEDEV ioctl.
The assumption is that the rfcomm tty driver will release the
rfcomm_dev reference when the tty is freed (in rfcomm_tty_cleanup()).
However, if the tty is never opened, the 'take over' never occurs,
so when RFCOMMRELEASEDEV ioctl is called, the reference is not
released.

Track the state of the reference 'take over' so that the release
is guaranteed by either the RFCOMMRELEASEDEV ioctl or the rfcomm tty
driver.

Note that the synchronous hangup in rfcomm_release_dev() ensures
that rfcomm_tty_install() cannot race with the RFCOMMRELEASEDEV ioctl.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/net/bluetooth/rfcomm.h | 1 +
 net/bluetooth/rfcomm/tty.c     | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 29d9727..6f3fbc5 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -332,6 +332,7 @@ int  rfcomm_connect_ind(struct rfcomm_session *s, u8 channel,
 
 /* rfcomm_dev.status bit definitions */
 #define RFCOMM_DEV_RELEASED   0
+#define RFCOMM_TTY_OWNED      1
 
 struct rfcomm_dev_req {
 	s16      dev_id;
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index d9d4bc8..bb570d9 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -441,7 +441,7 @@ static int rfcomm_release_dev(void __user *arg)
 		tty_kref_put(tty);
 	}
 
-	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
+	if (!test_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
 
 	tty_port_put(&dev->port);
@@ -685,8 +685,10 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	 * when the last process closes the tty. The behaviour is expected by
 	 * userspace.
 	 */
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
+		set_bit(RFCOMM_TTY_OWNED, &dev->status);
 		tty_port_put(&dev->port);
+	}
 
 	return 0;
 }
-- 
1.8.1.2

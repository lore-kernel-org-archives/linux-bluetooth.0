Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	stable@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 4/4] rfcomm: remove rfcomm_carrier_raised()
Date: Mon,  6 Jan 2014 21:23:53 +0100
Message-Id: <1389039834-24491-5-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the rfcomm_carrier_raised() definition as that function isn't
used anymore.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index aeabade..f9c0980a 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -160,14 +160,6 @@ static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
 	return err;
 }
 
-/* we block the open until the dlc->state becomes BT_CONNECTED */
-static int rfcomm_dev_carrier_raised(struct tty_port *port)
-{
-	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
-
-	return (dev->dlc->state == BT_CONNECTED);
-}
-
 /* device-specific cleanup: close the dlc */
 static void rfcomm_dev_shutdown(struct tty_port *port)
 {
-- 
1.8.5.2

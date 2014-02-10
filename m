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
Subject: [PATCH 17/24] Bluetooth: Rename __rfcomm_dev_get() to __rfcomm_dev_lookup()
Date: Sun,  9 Feb 2014 20:59:17 -0500
Message-Id: <1391997564-1805-18-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Functions which search lists for matching id's are more
commonly named *_lookup, which is the convention in the
bluetooth core as well.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index fa1226f..4a38b54 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -140,7 +140,7 @@ static const struct tty_port_operations rfcomm_port_ops = {
 	.carrier_raised = rfcomm_dev_carrier_raised,
 };
 
-static struct rfcomm_dev *__rfcomm_dev_get(int id)
+static struct rfcomm_dev *__rfcomm_dev_lookup(int id)
 {
 	struct rfcomm_dev *dev;
 
@@ -157,7 +157,7 @@ static struct rfcomm_dev *rfcomm_dev_get(int id)
 
 	spin_lock(&rfcomm_dev_lock);
 
-	dev = __rfcomm_dev_get(id);
+	dev = __rfcomm_dev_lookup(id);
 
 	if (dev && !tty_port_get(&dev->port))
 		dev = NULL;
-- 
1.8.1.2

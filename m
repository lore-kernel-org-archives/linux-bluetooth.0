Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 11/34] Bluetooth: A2MP: Add channel close callback
Date: Thu, 19 Jan 2012 11:20:00 +0200
Message-Id: <1326964823-26747-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 247a543..3e306dc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,8 +16,16 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+static void a2mp_chan_close_cb(void *data)
+{
+	struct amp_mgr *mgr = data;
+
+	l2cap_chan_destroy(mgr->a2mp_chan);
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
+	.close		= a2mp_chan_close_cb,
 };
 
 static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
-- 
1.7.4.1


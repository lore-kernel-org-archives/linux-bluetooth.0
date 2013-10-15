Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add l2cap_chan_no_resume stub for A2MP
Date: Tue, 15 Oct 2013 16:47:11 -0700
Message-Id: <1381880831-65322-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The A2MP client for L2CAP channels needs to use l2cap_chan_no_resume
empty stub function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 4 ++++
 net/bluetooth/a2mp.c          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 377db2a..3d922b9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -797,6 +797,10 @@ static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_resume(struct l2cap_chan *chan)
+{
+}
+
 static inline void l2cap_chan_no_set_shutdown(struct l2cap_chan *chan)
 {
 }
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 74c1477..fe32a33 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -710,6 +710,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
+	.resume = l2cap_chan_no_resume,
 	.set_shutdown = l2cap_chan_no_set_shutdown,
 	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
 };
-- 
1.8.3.1


Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Mar 2009 16:54:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix removing of dlc timer with DEFER_SETUP
Message-ID: <20090326145404.GA14177@jh-x301>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There seems to be a missing call to rfcomm_dlc_clear_timer when accepting
RFCOMM connections for a socket with DEFER_SETUP. This is easily noticable with
several headsets by them getting disconnected after about 20 seconds even
though the connection from them has been properly accepted on the userspace
side by bluetoothd.

I'm not 100% sure of the correctness of this patch regarding the placement of
this rfcomm_dlc_clear_timer call but it seems to do the trick. What also makes
me a little uncertain is that the issue is not reproducable with some headsets
so there must be *some* code path for accepting connections that does work.
With most dual-profile headsets or those that do more advanced SDP stuff during
the connection setup this is fairly easily reproducable though.

So, any comments about the patch are welcome.

Johan

--ew6BAiZeqk4r7MaW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Fix-removing-of-dlc-timer-with-DEFER_SETU.patch"

>From d60c77fd23b4f5043351829c6f0213f5230360d6 Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Thu, 26 Mar 2009 16:41:56 +0200
Subject: [PATCH] Bluetooth: Fix removing of dlc timer with DEFER_SETUP

There's a missing call to rfcomm_dlc_clear_timer in the case that DEFER_SETUP
is used and so the connection gets disconnected after the timeout even if it
was successfully accepted previously.

This patch adds a call to rfcomm_dlc_clear_timer to rfcomm_dlc_accept which
will get called when the user accepts the connection by calling read() on the
socket.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/rfcomm/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 1d0fb0f..374536e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1194,6 +1194,8 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 
 	rfcomm_send_ua(d->session, d->dlci);
 
+	rfcomm_dlc_clear_timer(d);
+
 	rfcomm_dlc_lock(d);
 	d->state = BT_CONNECTED;
 	d->state_change(d, 0);
-- 
1.6.0.4


--ew6BAiZeqk4r7MaW--

Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	gustavo@padovan.org
Cc: Dean_Jenkins@mentor.com
Subject: [RFC] Bluetooth: Make rfcomm_dlc_clear_timer() SMP safe
Date: Fri, 25 Jul 2014 13:58:12 +0100
Message-Id: <1406293092-3000-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_dlc_clear_timer() is used to cancel the timer
expiry callback rfcomm_dlc_timeout(). However, del_timer()
was used to cancel the timer which is not always SMP safe.

If del_timer() returns a non-zero result then
rfcomm_dlc_clear_timer() calls rfcomm_dlc_put(d) which decrements
d->refcnt and if the refcnt becomes zero it frees the structure
rfcomm_dlc pointed to by d.

If rfcomm_dlc_timeout() runs then it also calls rfcomm_dlc_put(d)
which decrements d->refcnt and if the refcnt becomes zero it frees
the structure rfcomm_dlc pointed to by d.

del_timer() may not prevent rfcomm_dlc_timeout() running on
another CPU when del_timer() returns a non-zero value. This race
condition allows rfcomm_dlc_put(d) to be called twice which
results in a malfunction of the refcnt value as the refcnt is
decremented 1 time too many. This potentially leads to an early
freeing of the rfcomm_dlc structure. Consequently, further decrements
of d->refcnt may be performed on freed memory which will cause memory
corruption.

The solution is to use del_timer_sync() instead of del_timer()
because del_timer_sync() will wait for rfcomm_dlc_timeout() to
complete execution (assumes rfcomm_dlc_timeout() was scheduled
to run at the point del_timer_sync() was called).

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/rfcomm/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index af73bc3..f9de2ee 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -279,7 +279,7 @@ static void rfcomm_dlc_clear_timer(struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p state %ld", d, d->state);
 
-	if (del_timer(&d->timer))
+	if (del_timer_sync(&d->timer))
 		rfcomm_dlc_put(d);
 }
 
-- 
1.7.9.5

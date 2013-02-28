Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH v2 1/6] Bluetooth: Avoid rfcomm_session_timeout using freed session
Date: Thu, 28 Feb 2013 14:21:53 +0000
Message-Id: <1362061318-30580-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use del_timer_sync() instead of del_timer() as this ensures
that rfcomm_session_timeout() is not running on a different
CPU when rfcomm_session_put() is called. This avoids a race
condition on SMP systems because potentially
rfcomm_session_timeout() could reuse the freed RFCOMM session
structure caused by the execution of rfcomm_session_put().

Note that this modification makes the reason for the RFCOMM
session refcnt mechanism redundant.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 201fdf7..8780e67 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -257,7 +257,7 @@ static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
 	BT_DBG("session %p state %ld", s, s->state);
 
-	if (timer_pending(&s->timer) && del_timer(&s->timer))
+	if (del_timer_sync(&s->timer))
 		rfcomm_session_put(s);
 }
 
-- 
1.7.10.1

Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH v2 5/6] Bluetooth: Remove redundant call to rfcomm_send_disc
Date: Thu, 28 Feb 2013 14:21:57 +0000
Message-Id: <1362061318-30580-6-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In rfcomm_session_del() remove the redundant call to
rfcomm_send_disc() because it is not possible for the
session to be in BT_CONNECTED state during deletion
of the session.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/core.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index af97fa2..db0b9aa 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -627,9 +627,6 @@ static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s)
 
 	list_del(&s->list);
 
-	if (state == BT_CONNECTED)
-		rfcomm_send_disc(s, 0);
-
 	rfcomm_session_clear_timer(s);
 	sock_release(s->sock);
 	kfree(s);
-- 
1.7.10.1

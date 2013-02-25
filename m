Return-Path: <cyrus@holtmann.org>
From: dean_jenkins@mentor.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org
Subject: [PATCH 5/6] Bluetooth: Remove redundant call to rfcomm_send_disc
Date: Mon, 25 Feb 2013 16:38:36 +0000
Message-Id: <1361810317-4005-6-git-send-email-dean_jenkins@mentor.com>
In-Reply-To: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
References: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dean Jenkins <Dean_Jenkins@mentor.com>

In rfcomm_session_del() remove the redundant call to
rfcomm_send_disc() because it is not possible for the
session to be in BT_CONNECTED state during deletion
of the session.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/rfcomm/core.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ecef9bc..3bdaf2e 100644
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

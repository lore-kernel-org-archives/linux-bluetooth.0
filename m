Return-Path: <cyrus@holtmann.org>
Message-ID: <1361555483.13060.2.camel@dellpc>
Subject: [PATCH] hidp: Ensure the session is marked as terminating to enable
 other functions to abort early.
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@gmail.com, Marcel Holtmann <marcel@holtmann.org>, Gustavo
	Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 22 Feb 2013 17:51:23 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Karl Relton <karllinuxtest.relton@ntlworld.com>

Ensure the session is marked as terminating no matter how hidp_session
drops out of its main loop.

This enables other functions (such as hidp_get_raw_report) to
abort early once a session is in its closing
stages - important since the cleanup of a session will remove
input/hid devices which (via the power_supply code) will typically
trigger a call to hidp_get_raw_report for an ill-fated attempt to
get the battery status. Without this change hidp_get_raw_report
can end up stalling the cleanup process for its 5 second timeout.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b2bcbe2..ba9badc 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -722,6 +722,7 @@ static int hidp_session(void *arg)
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING);
+	atomic_inc(&session->terminate);
 	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
 	remove_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
 
-- 
1.7.9.5

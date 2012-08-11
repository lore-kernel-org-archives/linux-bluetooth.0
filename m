Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Avoid rfcomm_session_timeout using freed pointer
Date: Sat, 11 Aug 2012 19:47:09 +0100
Message-Id: <1344710830-10301-4-git-send-email-djenkins@mvista.com>
In-Reply-To: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
References: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm_session_timeout() protects the scenario of the remote
Bluetooth device failing to send a DISC on the rfcomm control
channel after the last data DLC channel has been closed.

There is a race condition between the timer expiring causing
rfcomm_session_timeout() to run and the rfcomm session being
deleted. If the rfcomm session is deleted then
rfcomm_session_timeout() would use a freed rfcomm session
pointer resulting in a potential kernel crash or memory corruption.
Note the timer is cleared before the rfcomm session is deleted
by del_timer() so the circumstances for a failure to occur are
as follows:

rfcomm_session_timeout() needs to be executing before the
del_timer() is called to clear the timer but
rfcomm_session_timeout() needs to be delayed from using the
rfcomm session pointer until after the session has been deleted.
Therefore, there is a very small window of opportunity for failure.

The solution is to use del_timer_sync() instead of del_timer()
as this ensures that rfcomm_session_timeout() is not running
when del_timer_sync() returns. This means that it is not
possible for rfcomm_session_timeout() to run after the rfcomm
session has been deleted.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 net/bluetooth/rfcomm/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 24d4d3c..c7921fd 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -264,8 +264,8 @@ static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
 	BT_DBG("session %p state %ld", s, s->state);
 
-	if (timer_pending(&s->timer))
-		del_timer(&s->timer);
+	/* ensure rfcomm_session_timeout() is not running past this point */
+	del_timer_sync(&s->timer);
 }
 
 /* ---- RFCOMM DLCs ---- */
-- 
1.7.10.1


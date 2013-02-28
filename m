Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCH v2 2/6] Bluetooth: Check rfcomm session and DLC exists on socket close
Date: Thu, 28 Feb 2013 14:21:54 +0000
Message-Id: <1362061318-30580-3-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

A race condition exists between near simultaneous asynchronous
DLC data channel disconnection requests from the host and remote device.
This causes the socket layer to request a socket shutdown at the same
time the rfcomm core is processing the disconnect request from the remote
device.

The socket layer retains a copy of a struct rfcomm_dlc d pointer.
The d pointer refers to a copy of a struct rfcomm_session.
When the socket layer thread performs a socket shutdown, the thread
may wait on a rfcomm lock in rfcomm_dlc_close(). This means that
whilst the thread waits, the rfcomm_session and/or rfcomm_dlc structures
pointed to by d maybe freed due to rfcomm core handling. Consequently,
when the rfcomm lock becomes available and the thread runs, a
malfunction could occur as a freed rfcomm_session structure and/or a
freed rfcomm_dlc structure will be erroneously accessed.

Therefore, after the rfcomm lock is acquired, check that the struct
rfcomm_session is still valid by searching the rfcomm session list.
If the session is valid then validate the d pointer by searching the
rfcomm session list of active DLCs for the rfcomm_dlc structure
pointed by d.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/core.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8780e67..ae7124e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -493,12 +493,34 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 
 int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 {
-	int r;
+	int r = 0;
+	struct rfcomm_dlc *d_list;
+	struct rfcomm_session *s, *s_list;
+
+	BT_DBG("dlc %p state %ld dlci %d err %d", d, d->state, d->dlci, err);
 
 	rfcomm_lock();
 
-	r = __rfcomm_dlc_close(d, err);
+	s = d->session;
+	if (!s)
+		goto no_session;
+
+	/* after waiting on the mutex check the session still exists
+	 * then check the dlc still exists
+	 */
+	list_for_each_entry(s_list, &session_list, list) {
+		if (s_list == s) {
+			list_for_each_entry(d_list, &s->dlcs, list) {
+				if (d_list == d) {
+					r = __rfcomm_dlc_close(d, err);
+					break;
+				}
+			}
+			break;
+		}
+	}
 
+no_session:
 	rfcomm_unlock();
 	return r;
 }
-- 
1.7.10.1

Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 05/16] Bluetooth: hidp: test "terminate" before sleeping
Date: Sat,  6 Apr 2013 20:28:41 +0200
Message-Id: <1365272932-571-6-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "terminate" flag is guaranteed to be set before the session terminates
and the handlers are woken up. Hence, we need to add it to the
sleep-condition.

Note that testing the flags is not enough as nothing prevents us from
setting the flags again after the session-handler terminated.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 22e9ab1..e01a924 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -330,11 +330,13 @@ static int hidp_get_raw_report(struct hid_device *hid,
 
 	/* Wait for the return of the report. The returned report
 	   gets put in session->report_return.  */
-	while (test_bit(HIDP_WAITING_FOR_RETURN, &session->flags)) {
+	while (test_bit(HIDP_WAITING_FOR_RETURN, &session->flags) &&
+	       !atomic_read(&session->terminate)) {
 		int res;
 
 		res = wait_event_interruptible_timeout(session->report_queue,
-			!test_bit(HIDP_WAITING_FOR_RETURN, &session->flags),
+			!test_bit(HIDP_WAITING_FOR_RETURN, &session->flags)
+				|| atomic_read(&session->terminate),
 			5*HZ);
 		if (res == 0) {
 			/* timeout */
@@ -399,11 +401,13 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 		goto err;
 
 	/* Wait for the ACK from the device. */
-	while (test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags)) {
+	while (test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags) &&
+	       !atomic_read(&session->terminate)) {
 		int res;
 
 		res = wait_event_interruptible_timeout(session->report_queue,
-			!test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags),
+			!test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags)
+				|| atomic_read(&session->terminate),
 			10*HZ);
 		if (res == 0) {
 			/* timeout */
-- 
1.8.2


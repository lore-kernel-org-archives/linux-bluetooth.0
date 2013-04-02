Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 07/18] Bluetooth: hidp: test "terminate" before sleeping
Date: Tue,  2 Apr 2013 18:08:27 +0200
Message-Id: <1364918918-2336-8-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "terminate" flag is guaranteed to be set before the session terminates
and the handlers are woken up. Hence, we need to add it to the
sleep-condition.

Note that testing the flags is not enough as nothing prevents us from
setting the flags again after the session-handler terminated.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 413b900..2a179ad 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -327,11 +327,13 @@ static int hidp_get_raw_report(struct hid_device *hid,
 
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
@@ -396,11 +398,13 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
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


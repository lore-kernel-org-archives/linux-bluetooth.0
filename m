Return-Path: <cyrus@holtmann.org>
Message-ID: <1359478332.2729.3.camel@dellpc>
Subject: [PATCH] hidp: Make hidp_get_raw_report abort if the session is
 terminating
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 29 Jan 2013 16:52:12 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Karl Relton <karllinuxtest.relton@ntlworld.com>

After linux 3.2 the hid_destroy_device call in hidp_session cleaning up
invokes a hook to the power_supply code which in turn tries to read the
battery capacity. This read will trigger a call to hidp_get_raw_report
which is bound to fail because the device is being taken away - so rather
than wait for the 5 second timeout failure this change enables it to fail
straight away.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
---
 net/bluetooth/hidp/core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b2bcbe2..a4c1bb0 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -311,6 +311,9 @@ static int hidp_get_raw_report(struct hid_device *hid,
 	int numbered_reports = hid->report_enum[report_type].numbered;
 	int ret;
 
+	if (atomic_read(&session->terminate))
+		return -EIO;
+
 	switch (report_type) {
 	case HID_FEATURE_REPORT:
 		report_type = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
@@ -695,8 +698,10 @@ static int hidp_session(void *arg)
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!atomic_read(&session->terminate)) {
 		if (ctrl_sk->sk_state != BT_CONNECTED ||
-				intr_sk->sk_state != BT_CONNECTED)
+				intr_sk->sk_state != BT_CONNECTED) {
+			atomic_inc(&session->terminate);
 			break;
+		}
 
 		while ((skb = skb_dequeue(&intr_sk->sk_receive_queue))) {
 			skb_orphan(skb);
-- 
1.7.9.5




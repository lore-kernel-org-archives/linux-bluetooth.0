Return-Path: <cyrus@holtmann.org>
Message-ID: <1361384179.5261.15.camel@dellpc>
Subject: [PATCH v2] hidp: Make hidp_get_raw_report abort if the session is
 terminating.
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@gmail.com, Marcel Holtmann <marcel@holtmann.org>, Gustavo
	Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 20 Feb 2013 18:16:19 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Karl Relton <karllinuxtest.relton@ntlworld.com>

 After linux 3.2 the hid_destroy_device call in hidp_session
 cleaning up invokes a hook to the power_supply code which
 in turn tries to read the battery capacity. This read will
 trigger a call to hidp_get_raw_report which is bound to fail
 because the device is being taken away - so rather than
 wait for the 5 second timeout failure this changes enables
 it to fail straight away.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b2bcbe2..4b26ea7 100644
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
@@ -722,6 +725,7 @@ static int hidp_session(void *arg)
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING);
+	atomic_inc(&session->terminate);
 	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
 	remove_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
 
-- 
1.7.9.5

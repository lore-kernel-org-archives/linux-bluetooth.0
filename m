Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	peter@hurleysoftware.com,
	dh.herrmann@googlemail.com
Subject: [RFC] Bluetooth: hidp: Check for valid ACL connection
Date: Fri, 19 Aug 2011 16:41:18 +0200
Message-Id: <1313764878-3091-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Check for valid ACL connection before creating an hid device.
__hidp_link_session() needs session->conn but hidp_add_connection does not check
whether session->conn is set.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---

I recently got several kernel panics in hidp_add_connection when creating a
bluetooth HID device. I got these panics when the device shut down *while*
trying to initiate the HID connection.
This fix aborts the HID device creation if the ACL connection is disconnected.
This fixes the problem for me but I don't know whether there is still a
race-condition between obtainig session->conn and calling hci_conn_hold_device
in __hidp_link_session().

Also I think it would make the code nicer when calling hidp_get_device() in
hidp_add_connection and hidp_setup_input/hid just retrieves the parent-device
from session->conn.

Anyway, you can find my kernel oops message here:
https://gist.github.com/1156759
As far as I got, it is caused by:
hidp_add_connection()
 -> __hidp_link_session()
  -> hci_conn_hold_device()
   -> atomic_inc()
    -> test_and_set_bit()

Regards
David

 net/bluetooth/hidp/core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index fb68f34..baec330 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -837,6 +837,11 @@ static int hidp_setup_input(struct hidp_session *session,
 	}
 
 	input->dev.parent = hidp_get_device(session);
+	if (!input->dev.parent) {
+		input_free_device(input);
+		session->input = NULL;
+		return -ENODEV;
+	}
 
 	input->event = hidp_input_event;
 
@@ -941,6 +946,9 @@ static int hidp_setup_hid(struct hidp_session *session,
 	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
 
 	hid->dev.parent = hidp_get_device(session);
+	if (!hid->dev.parent)
+		goto dev_err;
+
 	hid->ll_driver = &hidp_hid_driver;
 
 	hid->hid_get_raw_report = hidp_get_raw_report;
@@ -948,6 +956,9 @@ static int hidp_setup_hid(struct hidp_session *session,
 
 	return 0;
 
+dev_err:
+	hid_destroy_device(hid);
+	session->hid = NULL;
 fault:
 	kfree(session->rd_data);
 	session->rd_data = NULL;
-- 
1.7.6

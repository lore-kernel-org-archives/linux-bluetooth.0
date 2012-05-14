Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 May 2012 16:30:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org
Subject: re: Bluetooth: Fix input device registration
Message-ID: <20120514132955.GA13369@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I am working on some new stuff for Smatch and sending bug reports
on potential bugs I find as I go.

----
This is a semi-automatic email about new static checker warnings.

The patch 3415a5fdde71: "Bluetooth: Fix input device registration" 
from Oct 6, 2011, leads to the following Smatch complaint:

net/bluetooth/hidp/core.c:1072 hidp_add_connection()
	 error: we previously assumed 'session->input' could be null (see line 1049)

net/bluetooth/hidp/core.c
  1046          if (session->hid) {
  1047                  vendor  = session->hid->vendor;
  1048			product = session->hid->product;
  1049		} else if (session->input) {
  1050			vendor  = session->input->id.vendor;
  1051			product = session->input->id.product;
  1052		} else {
                ^^^^^^^^
If we hit this else clause then "session->input" and "session->hid" are
both NULL.

  1053			vendor = 0x0000;
  1054			product = 0x0000;
  1055		}
  1056	
  1057		session->task = kthread_run(hidp_session, session, "khidpd_%04x%04x",
  1058								vendor, product);
  1059		if (IS_ERR(session->task)) {
  1060			err = PTR_ERR(session->task);
  1061			goto unlink;
  1062		}
  1063	
  1064		while (session->waiting_for_startup) {
  1065			wait_event_interruptible(session->startup_queue,
  1066				!session->waiting_for_startup);
  1067		}
  1068	
  1069		if (session->hid)
  1070			err = hid_add_device(session->hid);
  1071		else
  1072			err = input_register_device(session->input);
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It leads to a NULL dereference inside the input_register_device() call.

  1073	
  1074		if (err < 0) {

regards,
dan carpenter


Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
Date: Fri, 24 Jan 2014 21:54:00 -0400
Message-Id: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches extend existing tests in l2cap-tester to exercise two common
operations on LE sockets:

* getsockopt(BT_SECURITY) on client side (to set security level)
* setsockopt(L2CAP_OPTIONS) on server side (called by bt_io_get())

At the moment, there is a regression on kernel introduced by commit
a5a1e0e6b9c1dea3696192b5ec153d03917eb7b8 ("Bluetooth: Switch ATT channels to
use L2CAP_CHAN_FIXED") which is affecting these two operations. I'm currently
implementing and testing fixes for this regression.

PS: For some reason, the following tests are failing on my system, even using
an older kernel:

L2CAP LE Client - Success
L2CAP LE Client SMP - Success
L2CAP LE Client - Command Reject
L2CAP LE Client - Invalid PSM
L2CAP LE Server - Success

connect() is returning EINVAL.  Any ideas for why this may be happening?

Best Regards,
Anderson Lizardo

Anderson Lizardo (2):
  tools/l2cap-tester: Test setsockopt(BT_SECURITY) on LE client
  tools/l2cap-tester: Test getsockopt(L2CAP_OPTIONS) on LE server

 tools/l2cap-tester.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
1.8.3.2


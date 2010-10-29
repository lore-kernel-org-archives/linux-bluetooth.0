Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/2] Fix kernel crash in rfcomm/l2cap
Date: Fri, 29 Oct 2010 16:42:59 +0300
Message-Id: <1288359781-4059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Yet another version of patches fixing kernel crash in RFCOMM / L2CAP.

Do not delete l2cap channel and socket sk when sk is owned by user.
To delete l2cap channel standard timer is used.

lock_sock and release_sock do not hold a normal spinlock directly but 
instead hold the owner field. This means bh_lock_sock can still execute
even if the socket is "locked". More info can be found here:
http://www.linuxfoundation.org/collaborate/workgroups/networking/socketlocks

When sending following sequence:
...
No.     Time        Source                Destination           Protocol Info
    89 1.951202            RFCOMM   Rcvd DISC DLCI=20
    90 1.951324            RFCOMM   Sent UA DLCI=20
    91 1.959381            HCI_EVT   Number of Completed Packets
    92 1.966461            RFCOMM   Rcvd DISC DLCI=0
    93 1.966492            L2CAP    Rcvd Disconnect Request
    94 1.972595            L2CAP    Sent Disconnect Response

...

krfcommd kernel thread is preempted with l2cap tasklet which remove l2cap_conn
(L2CAP connection handler structure). Then rfcomm thread tries to send RFCOMM
UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn crash
happens.

Andrei Emeltchenko (2):
  Bluetooth: Check sk is not owned before freeing l2cap_conn
  Bluetooth: timer check sk is not owned before freeing

 net/bluetooth/l2cap.c |   58 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 46 insertions(+), 12 deletions(-)


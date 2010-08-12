Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/2] Fix kernel crash in rfcomm/l2cap
Date: Thu, 12 Aug 2010 16:25:35 +0300
Message-Id: <1281619537-30096-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Version 2 of patches fixing kernel crash in RFCOMM / L2CAP.

Do not delete l2cap channel and socket sk when sk is owned by user.
To delete l2cap channel standard timer is used.

lock_sock and release_sock do not hold a normal spinlock directly but 
instead hold the owner field. This means bh_lock_sock can still execute
even if the socket is "locked". More info can be found here:
http://www.linuxfoundation.org/collaborate/workgroups/networking/socketlocks

Andrei Emeltchenko (2):
  Bluetooth: Check sk is not owned before freeing l2cap_conn
  Bluetooth: timer check sk is not owned before freeing

 net/bluetooth/l2cap.c |   57 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 45 insertions(+), 12 deletions(-)


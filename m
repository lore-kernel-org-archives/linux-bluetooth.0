Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Associate connectable setting with adv type
Date: Mon, 14 Oct 2013 21:15:23 +0300
Message-Id: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a rewritten patch set to allow associating the connectable
setting with the advertising type. Unlike the first attempt this one
doesn't introduce a new parameter to enable_advertising() but instead
does a pending mgmt command lookup to help determine the right
advertising type.

There's also a fourth patch to do similar refactoring for
set_discoverable as we did for set_connectable wrt. splitting raw HCI
sockets from mgmt control, but I didn't quite get around to tying that
to the advertising data yet (the general discoverable flag).

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Make Set Connectable also update the LE advertising type
      Bluetooth: Move set_bredr_scan() to avoid forward declaration
      Bluetooth: Fix updating scan mode in set_bredr()
      Bluetooth: Convert Set Discoverable to use an asynchronous request

 net/bluetooth/mgmt.c | 144 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 109 insertions(+), 35 deletions(-)


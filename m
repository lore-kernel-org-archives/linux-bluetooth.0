Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/3] Bluetooth: L2CAP robustness fixes
Date: Thu,  9 Sep 2010 10:42:58 +0300
Message-Id: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Fixes increase L2CAP robustness to DOS attacks to BT stack.

Andrei Emeltchenko (3):
  Bluetooth: fix MTU L2CAP configuration parameter
  Bluetooth: check for l2cap header in start fragment
  Bluetooth: check L2CAP length in first ACL fragment

 net/bluetooth/l2cap.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)


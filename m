Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/3] Bluetooth: L2CAP robustness fixes
Date: Wed, 15 Sep 2010 14:28:41 +0300
Message-Id: <1284550124-31201-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Fixes increase L2CAP robustness to DOS attacks to BT stack.
Updated version after comments from Mat Martineau <mathewm@codeaurora.org>
and Gustavo Padovan <padovan@profusion.mobi>.

Andrei Emeltchenko (3):
  Bluetooth: fix MTU L2CAP configuration parameter
  Bluetooth: check for l2cap header in start fragment
  Bluetooth: check L2CAP length in first ACL fragment

 net/bluetooth/l2cap.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)


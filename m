Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Fix checkpatch warnings
Date: Tue, 11 Jan 2011 17:20:19 +0200
Message-Id: <1294759220-5002-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

v2: taking comments from Anderson Lizardo.

Andrei Emeltchenko (1):
  Bluetooth: Do not use assignments in IF conditions

 net/bluetooth/af_bluetooth.c |    6 ++++--
 net/bluetooth/cmtp/capi.c    |    3 ++-
 net/bluetooth/cmtp/core.c    |    9 ++++++---
 net/bluetooth/hci_core.c     |   12 +++++++++---
 net/bluetooth/hci_event.c    |   22 ++++++++++++++--------
 net/bluetooth/hidp/core.c    |    9 ++++++---
 net/bluetooth/l2cap.c        |    5 ++++-
 7 files changed, 45 insertions(+), 21 deletions(-)


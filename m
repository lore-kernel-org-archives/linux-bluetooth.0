Return-Path: <cyrus@holtmann.org>
From: Seungyoun Ju <sy39.ju@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH 0/3] Bluetooth: Add L2CAP socket option for connection params
Date: Thu, 17 Sep 2015 15:57:17 +0900
Message-Id: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches implement a L2CAP socket option to update and get
LE connection parameters.

Seungyoun Ju (3):
  Bluetooth: Add L2CAP socket option for connection params
  Bluetooth: Update LE connecion parameters depending on LE features
  Bluetooth: Implement L2CAP socket option for connection params

 include/net/bluetooth/bluetooth.h |  8 +++++
 include/net/bluetooth/l2cap.h     |  2 ++
 net/bluetooth/l2cap_core.c        | 45 ++++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c        | 63 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 9 deletions(-)

-- 
2.1.0


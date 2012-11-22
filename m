Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH 0/3] mgmt:  read supported codecs
Date: Thu, 22 Nov 2012 13:47:45 +0100
Message-Id: <1353588468-28711-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements the user space side of the read codecs command.

Michael Knudsen (3):
  Bluetooth:  Add HCI Coding Format definitions
  Bluetooth:  Support the read codecs operation
  Doco:  List the read codecs operation

 doc/mgmt-api.txt |   20 +++++++++++++++
 lib/hci.h        |    9 +++++++
 lib/mgmt.h       |    8 ++++++
 tools/btmgmt.c   |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)

-- 
1.7.9.5


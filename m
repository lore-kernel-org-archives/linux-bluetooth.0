Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: More patches to eL2CAP
Date: Wed, 14 Apr 2010 16:41:45 -0300
Message-Id: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches fix two bugs, add L2CAP Extended Features to the Kconfig.
And as a RFC implements support for SOCK_STREAM and Local Busy condition
(patches 5 and 7). Comments are welcome. :)

The patchset is rebased against my last patchset sent to this mailing list.

Gustavo F. Padovan (7):
      Bluetooth: Fix bug when retransmitting I-frames
      Bluetooth: Fix Indentation on L2CAP
      Bluetooth: Fix crash when monitor timeout expires
      Bluetooth: Add Kconfig option for L2CAP Extended Features
      Bluetooth: Add SOCK_STREAM support to L2CAP
      Bluetooth: Implement missing parts of the Invalid Frame Detection
      Bluetooth: Implement Local Busy Condition handling

 include/net/bluetooth/l2cap.h |    6 +
 net/bluetooth/Kconfig         |   13 ++
 net/bluetooth/l2cap.c         |  331 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 320 insertions(+), 30 deletions(-)

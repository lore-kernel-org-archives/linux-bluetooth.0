Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Arman Uguray <armansito@chromium.org>
Subject: [PATCH 0/2] shared/att: Improve client support.
Date: Mon,  7 Jul 2014 22:04:59 -0700
Message-Id: <1404795901-29367-1-git-send-email-armansito@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set makes the following additions/changes:

  - The opcode + param structure semantics are no longer used. bt_att_send now
    takes in the PDU as it will be sent over the physical link and it won't
    perform any explicit encoding or decoding of PDUs between host order and BT
    order. Any packed structs that get passed to bt_att_send need to be
    formatted according to the correct endianness.

  - bt_att_register and bt_att_unregister* functions are implemented. Callbacks
    are registered for a particular opcode and they get invoked when an incoming
    PDU of type "request", "indication", or "notification" is received.

This provides the basic functionality needed to implement a GATT client layer,
except for PDU signing and verifications of incoming signed PDUs. This isn't
immediately needed to implement a functioning client and could be left to the
upper layer.

Arman Uguray (2):
  shared/att: Remove parameters structures.
  shared/att: Implement bt_att_register.

 src/shared/att-types.h | 153 +-------------------
 src/shared/att.c       | 383 ++++++++++++++++++++++++++++++++-----------------
 src/shared/att.h       |  19 +--
 3 files changed, 267 insertions(+), 288 deletions(-)

-- 
2.0.0.526.g5318336

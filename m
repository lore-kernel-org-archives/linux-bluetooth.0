Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 0/4] bt_att initial implementation.
Date: Mon,  9 Jun 2014 18:33:56 -0700
Message-Id: <1402364040-11502-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3:
  - Split the first patch "Introduce struct bt_att" into 4 different patches.
  - Removed bt_att_send_sequential. Instead, there is now one bt_att_send that
  correctly returns an error if an invalid combination of opcode and callbacks
  is given.
  - Added a table of ATT protocol opcodes. Send operations and read events now
  route the PDU to the correct handler after explicitly checking the opcode
  type.
  - Added three separate write queues for requests, indications, and writes that
  don't require a control flow.
  - Replaced pending_list with two separate pointers for the currently pending
  request and indication.

Arman Uguray (4):
  src/shared/att: Introduce struct bt_att.
  src/shared/att: Implement basic boilerplate.
  src/shared/att: Implement write handler and bt_att_send.
  src/shared/att: Handle incoming response PDUs

 Makefile.am      |   3 +-
 src/shared/att.c | 786 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h | 261 ++++++++++++++++++
 3 files changed, 1049 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h

-- 
1.8.3.2


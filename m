Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v4 0/4] bt_att initial implementation
Date: Mon, 16 Jun 2014 15:43:56 -0700
Message-Id: <1402958640-1132-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4:
  - Changed get_op_type from a big switch statement to a function that walks a
  static const array that represents a table of ATT opcodes and their types.
  - Single bt_att_register function for incoming requests and notifications/
  indications.
  - Replaced bt_att_set_auth_signature with bt_att_set_signing_data, which takes
  in the CSRK and the sign counters, which will be used to generate the
  authentication signature for outgoing signed PDUs and to verify incoming
  signed PDUs.
  - Added bt_att_set_timeout_cb. Added a 30 second timeout for pending requests,
  after which the user will be notified and bt_att invalidated.
  - Moved parameter structure, opcode, and error code definitions to
  src/shared/att-types.h

Arman Uguray (4):
  src/shared/att: Introduce struct bt_att.
  src/shared/att: Implement basic boilerplate.
  src/shared/att: Implement write handler and bt_att_send.
  src/shared/att: Handle incoming response PDUs

 Makefile.am            |   3 +-
 src/shared/att-types.h | 222 +++++++++++++
 src/shared/att.c       | 862 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h       |  73 +++++
 4 files changed, 1159 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/att-types.h
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h

-- 
1.8.3.2


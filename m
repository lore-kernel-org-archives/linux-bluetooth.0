Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 00/10] bt_att initial implementation
Date: Fri, 16 May 2014 13:14:48 -0700
Message-Id: <1400271298-29769-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1:
   - Updated the copyright notice in new files to include Google Inc. Retained
   the Intel copyright in src/shared/att.c and unit/test-att.c which take a lot
   of code from src/shared/mgmt.c and unit/test-mgmt.c respectively.

   - Removed ATT_ERROR_IO from src/shared/att as 0x80 is a legitimate
   application error that varies among GATT profiles. On I/O errors, the code
   now invokes the callback with ATT_OP_ERROR_RESP with NULL parameters.

v2:
   - Renamed all opcode macros to look like BT_ATT_OP_* instead of ATT_OP_*.
   - Fixed bt_att_set_mtu to resize the internal buffer.
   - Renamed bt_att_send to bt_att_send_sequential, for sequential request/
   response and indication/confirmation flows. The non-sequential version will
   be called bt_att_send and not take in any callbacks.

Arman Uguray (10):
  src/shared/att: Introduce struct bt_att.
  unit/test-att: Add unit tests for src/shared/att.
  tools/btatt: Add command-line tool for ATT protocol testing.
  tools/btatt: Add "exchange-mtu" command.
  src/shared/att: Add "Find Information" request and response.
  unit/test-att: Add unit test for "Find Information" request/response.
  tools/btatt: Add "find-information" command.
  src/shared/att: Add "Find By Type Value" request and response.
  unit/test-att: Add unit test for "Find By Type Value"
    request/response.
  tools/btatt: Add "find-by-type-value" command.

 Makefile.am      |  12 +-
 Makefile.tools   |  10 +-
 src/shared/att.c | 694 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h | 131 +++++++++++
 tools/btatt.c    | 629 +++++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-att.c  | 474 +++++++++++++++++++++++++++++++++++++
 6 files changed, 1948 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h
 create mode 100644 tools/btatt.c
 create mode 100644 unit/test-att.c

-- 
1.8.3.2


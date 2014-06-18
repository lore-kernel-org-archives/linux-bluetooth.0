Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v5 0/4] bt_att initial implementation
Date: Wed, 18 Jun 2014 13:25:39 -0700
Message-Id: <1403123143-17543-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v5:
  - Removed the PDU signing related functions for now. We"ll revisit them once
  we start implementing/testing the signed write command.
  - Minor cosmetic changes.

Arman Uguray (4):
  src/shared/att: Introduce struct bt_att.
  src/shared/att: Implement basic boilerplate.
  src/shared/att: Implement write handler and bt_att_send.
  src/shared/att: Handle incoming response PDUs

 Makefile.am            |   3 +-
 src/shared/att-types.h | 222 +++++++++++++
 src/shared/att.c       | 840 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h       |  69 ++++
 4 files changed, 1133 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/att-types.h
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h

-- 
1.8.3.2


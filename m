Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 00/10] shared/att: Implement sending ATT protocol requests.
Date: Thu, 26 Jun 2014 16:14:07 -0700
Message-Id: <1403824457-22461-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds support for sending all remaining ATT protocol requests
via bt_att_send and handling of the corresponding response PDUs.

Implemented are:
  - All outgoing ATT protocol requests.
  - All incoming ATT protocol responses.

NOT implemented (and on the TODO list) are:
  - Outgoing ATT protocol commands.
  - Outgoing signed PDUs.
  - Outgoing notifications/indications.
  - Handling of incoming notifications/indications and outgoing confirmation.
  - Handling of incoming ATT protocol requests and outgoing responses.

Arman Uguray (10):
  shared/att: Implement outgoing "Find Information" request/response.
  shared/att: Implement outgoing "Find By Type Value" request/response.
  shared/att: Implement outgoing "Read By Type" request/response.
  shared/att: Implement outgoing "Read" request/response.
  shared/att: Implement outgoing "Read Blob" request/response.
  shared/att: Implement outgoing "Read Multiple" request/response.
  shared/att: Implement outgoing "Read By Group Type" request/response.
  shared/att: Implement outgoing "Write" request/response.
  shared/att: Implement outgoing "Prepare Write" request/response.
  shared/att: Implement outgoing "Execute Write" request/response.

 src/shared/att-types.h |  16 +-
 src/shared/att.c       | 551 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 559 insertions(+), 8 deletions(-)

-- 
2.0.0.526.g5318336


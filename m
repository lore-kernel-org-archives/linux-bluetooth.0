Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 00/11] shared/gatt-server: Implement ATT operations
Date: Fri,  7 Nov 2014 00:09:40 -0800
Message-Id: <1415347791-11716-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements the most important server-side ATT protocol
operations by interfacing with the new gatt-db API functions. All
requests except "Read Multiple" and "Signed Write Command" are provided
in this set.

This patch set also doesn't address checks for encryption/authentication/
authorization permissions. A TODO item has been added to address this
later.

Arman Uguray (11):
  shared/gatt-server: Implement "Read By Type" request.
  shared/gatt-server: Implement "Find Information" request.
  shared/gatt-server: Implement "Write" request and command.
  shared/gatt-server: Implement "Read" request.
  shared/gatt-server: Implement "Read Blob" request.
  shared/att: Handle incoming confirmation PDU.
  shared/gatt-server: Add functions for sending
    notifications/indications.
  shared/gatt-server: Implement "Prepare Write" request.
  shared/gatt-server: Implement "Execute Write" request.
  shared/gatt-client: Fix alignment warnings.
  TODO: Update shared/gatt-server items.

 TODO                     |   20 +-
 src/shared/att.c         |  119 +++--
 src/shared/gatt-client.c |    9 +-
 src/shared/gatt-server.c | 1231 +++++++++++++++++++++++++++++++++++++++++++---
 src/shared/gatt-server.h |   15 +
 5 files changed, 1266 insertions(+), 128 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5


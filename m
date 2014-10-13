Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 0/5] Introduce shared/gatt-server.
Date: Mon, 13 Oct 2014 14:09:57 -0700
Message-Id: <1413234602-20566-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v2:
  - Split read_by_grp_type_cb into two functions by moving the response PDU
    encoding loop into a helper function.

*v1:
  - Make gatt-db external to gatt-server, as initially discussed.
  - Also implement Read By Group Type request.

Arman Uguray (5):
  shared/att: Drop the connection if a request is received while one is
    pending.
  shared/att: Respond with ERROR_REQUEST_NOT_SUPPORTED for unhandled
    requests.
  shared/gatt-server: Introduce shared/gatt-server.
  shared/gatt-server: Support Exchange MTU request.
  shared/gatt-server: Support Read By Group Type request.

 Makefile.am              |   1 +
 src/shared/att.c         | 124 +++++++++++------
 src/shared/gatt-server.c | 356 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |  40 ++++++
 4 files changed, 481 insertions(+), 40 deletions(-)
 create mode 100644 src/shared/gatt-server.c
 create mode 100644 src/shared/gatt-server.h

-- 
2.1.0.rc2.206.gedb03e5


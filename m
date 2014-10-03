Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/3] Introduce shared/gatt-server.
Date: Fri,  3 Oct 2014 15:39:08 -0700
Message-Id: <1412375951-13940-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces shared/gatt-client and implements the server side of
ATT Exchange MTU request. I made the decision to keep gatt-db internal to
gatt-server due to the following reasons:

  1. I want to keep all ATT protocol details to remain internal to gatt-server
  and gatt-client. gatt-db creates a layering problem for attributes that get
  added with a high-level read/write handler. In this case, gatt-db leaves the
  responsibility of obtaining the attribute value and forming the ATT protocol
  response to the layer that registered the read handler. We want the actual PDU
  construction to be done by gatt-server, hence gatt-server needs to inject its
  own read/write handlers and provide a level of indirection to the upper-layer
  to obtain the value.

  My decision here is to write functions in the bt_gatt_server_* namespace to
  add/remove attributes into the database.

  2. This allows gatt-server to correctly send Service Changed indications
  without having the gatt-db modified behind its back.

  3. gatt-db exposes structures like shared/queue in its public interface which,
  after some mailing discussions, were decided to remain internal to shared
  code.

Arman Uguray (3):
  shared/att: Drop the connection is a request is received while one is
    pending.
  shared/gatt-server: Introduce shared/gatt-server.
  shared/gatt-server: Support Exchange MTU request.

 Makefile.am              |   1 +
 src/shared/att.c         | 101 +++++++++++++---------
 src/shared/gatt-server.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |  47 ++++++++++
 4 files changed, 328 insertions(+), 40 deletions(-)
 create mode 100644 src/shared/gatt-server.c
 create mode 100644 src/shared/gatt-server.h

-- 
2.1.0.rc2.206.gedb03e5


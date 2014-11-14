Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 0/6] Introduce tools/btgatt-server and other bug fixes.
Date: Fri, 14 Nov 2014 12:20:22 -0800
Message-Id: <1415996428-17528-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces tools/btgatt-server. This tool serves as a
standalone demo of combining shared/gatt-db, shared/gatt-server, and a
listening L2CAP socket on the ATT channel. The tool exposes the GAP and
GATT services, as well as a Heart Rate service. It's possible to hide/unhide
the latter to test Service Changed events.

The set also includes two small bug fixes for the way Service Changed
characteristics are handled by shared/gatt-client.

*v1: Fixed Luiz's comments:
     - Style fixes.
     - Make certain attribute values cached directly in gatt-db.
     - Added an ATT error response encoding API and packed struct.

*v2: Change bt_att_encode_error_rsp to bt_att_send_error_rsp.

*v3: Fixed Luiz's comments:
     - Fix all compile warnings and linker errors that are seen when patches in
       the set are compiled seperately.
     - Move btgatt-server experimental.

     Fixed Michael's comments:
     - Removed unnecessary memcpy after realloc.

Arman Uguray (6):
  tools/btgatt-server: Introduce btgatt-server.
  tools/btgatt-server: Accept incoming connection and initialize server.
  tools/btgatt-server: Populate the database.
  tools/btgatt-server: Add command support and the notify command.
  tools/btgatt-server: Add Heart Rate service simulation.
  tools/btgatt-server: Add "heart-rate" command.

 .gitignore            |    1 +
 Makefile.tools        |   11 +-
 tools/btgatt-server.c | 1086 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1095 insertions(+), 3 deletions(-)
 create mode 100644 tools/btgatt-server.c

-- 
2.1.0.rc2.206.gedb03e5


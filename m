Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/7] Introduce tools/btgatt-server and other bug fixes.
Date: Wed, 12 Nov 2014 16:36:40 -0800
Message-Id: <1415839007-21196-1-git-send-email-armansito@chromium.org>
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

Arman Uguray (7):
  shared/att: Add API for encoding ATT error response.
  tools/btgatt-server: Introduce btgatt-server.
  tools/btgatt-server: Accept incoming connection and initialize server.
  tools/btgatt-server: Populate the database.
  tools/btgatt-server: Add command support and the notify command.
  tools/btgatt-server: Add Heart Rate service simulation.
  tools/btgatt-server: Add "heart-rate" command.

 .gitignore                |    1 +
 Makefile.tools            |    8 +
 src/shared/att-types.h    |   12 +
 src/shared/att.c          |   58 ++-
 src/shared/att.h          |    3 +
 src/shared/gatt-client.c  |    8 +-
 src/shared/gatt-helpers.c |    8 +-
 src/shared/gatt-server.c  |  153 ++++---
 tools/btgatt-server.c     | 1088 +++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1257 insertions(+), 82 deletions(-)
 create mode 100644 tools/btgatt-server.c

-- 
2.1.0.rc2.206.gedb03e5


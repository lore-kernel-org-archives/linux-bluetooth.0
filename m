Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/8] Introduce tools/btgatt-server and other bug fixes.
Date: Tue, 11 Nov 2014 13:39:39 -0800
Message-Id: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces tools/btgatt-server. This tool serves as a
standalone demo of combining shared/gatt-db, shared/gatt-server, and a
listening L2CAP socket on the ATT channel. The tool exposes the GAP and
GATT services, as well as a Heart Rate service. It's possible to hide/unhide
the latter to test Service Changed events.

The set also includes two small bug fixes for the way Service Changed
characteristics are handled by shared/gatt-client.

Arman Uguray (8):
  tools/btgatt-server: Introduce btgatt-server.
  tools/btgatt-server: Accept incoming connection and initialize server.
  tools/btgatt-server: Populate the database.
  tools/btgatt-server: Add command support and the notify command.
  tools/btgatt-server: Add Heart Rate service simulation.
  tools/btgatt-server: Add "heart-rate" command.
  shared/gatt-client: Fix bug in service changed handler.
  shared/gatt-client: Watch CCC while registering Service Changed
    handler.

 .gitignore               |    1 +
 Makefile.tools           |    8 +
 src/shared/gatt-client.c |   25 +-
 tools/btgatt-server.c    | 1065 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1093 insertions(+), 6 deletions(-)
 create mode 100644 tools/btgatt-server.c

-- 
2.1.0.rc2.206.gedb03e5


Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 0/7] Introduce tools/btgatt-client.
Date: Sat, 30 Aug 2014 09:02:42 -0700
Message-Id: <1409414569-20068-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v2: Rebased on latest master & fixed conflicts in Makefile.tools
* v1: Removed L2CAP_LM socket options; using only BT_SECURITY now.

Arman Uguray (7):
  tools/btgatt-client: Introduce tools/btgatt-client
  tools/btgatt-client: Added L2CAP LE ATT connection.
  tools/btgatt-client: Integrate bt_att and bt_gatt_client.
  tools/btgatt-client: Add command parsing.
  tools/btgatt-client: Add "ready" handler.
  tools/btgatt-client: Add "services" command.
  tools/btgatt: Add command argument support.

 Makefile.tools        |  13 +-
 tools/btgatt-client.c | 657 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 669 insertions(+), 1 deletion(-)
 create mode 100644 tools/btgatt-client.c

-- 
2.1.0.rc2.206.gedb03e5


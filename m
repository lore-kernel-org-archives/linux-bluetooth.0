Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/7] Introduce tools/btgatt-client.
Date: Thu, 28 Aug 2014 15:15:06 -0700
Message-Id: <1409264113-12239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces tools/btgatt-client, which is an interactive
command-line tool for shared/gatt-client. It has proved useful for testing and
debugging the new shared GATT code, so I decided to send it upstream since I'm
sure others will eventually find this useful as well.

Current capabilities include outputting ATT protocol PDUs sent over the
underlying bt_att as verbose output, the initial MTU exchange, primary service &
characteristic discovery and a simple command to browse currently discovered and
cached services.

Comments are very much welcome.

Arman Uguray (7):
  tools/btgatt-client: Introduce tools/btgatt-client
  tools/btgatt-client: Added L2CAP LE ATT connection.
  tools/btgatt-client: Integrate bt_att and bt_gatt_client.
  tools/btgatt-client: Add command parsing.
  tools/btgatt-client: Add "ready" handler.
  tools/btgatt-client: Add "services" command.
  tools/btgatt: Add command argument support.

 Makefile.tools        |  14 +-
 tools/btgatt-client.c | 674 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 687 insertions(+), 1 deletion(-)
 create mode 100644 tools/btgatt-client.c

-- 
2.1.0.rc2.206.gedb03e5


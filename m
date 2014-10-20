Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/1]  Add GAttrib shim to bt_att
Date: Mon, 20 Oct 2014 09:57:23 -0700
Message-Id: <1413824244-35297-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a second implementation of GAttrib, which is backed
by the bt_att API instead.  It should enable a transition away from GAttrib
in favor of newer bt_att/bt_gatt_client implementations.

It is enabled by default, because once the transition starts, having it
disabled will result in breakage when simultaneously using bt_att
and GAttrib backed profiles.

Michael Janssen (1):
  GATT shim to src/shared bt_att

 Makefile.am             |   8 +-
 Makefile.tools          |  11 +-
 attrib/gattrib-shared.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac            |   4 +
 4 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 attrib/gattrib-shared.c

-- 
2.1.0.rc2.206.gedb03e5


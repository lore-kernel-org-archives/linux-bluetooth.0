Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/9] Commonalize functions appending to dbus message
Message-ID: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:33:00 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To improve maintainability, this patch set introduces common functions
for appending to dbus message.

ERAMOTO Masaya (9):
  gdbus: Introduce functions appending to dbus message
  obexd: Use g_dbus_dict_append_entry()
  obexd: Remove unused source/header files for dbus
  client: Use g_dbus_dict_append_*()
  mesh: Use g_dbus_dict_append_{entry,array}()
  tools/obexctl: Use g_dbus_dict_append_entry()
  tools/bluetooth-player: Use g_dbus_dict_append_entry()
  unit/test-gdbus-client: Use g_dbus_dict_append_entry()
  dbus-common: Remove unused functions due to use of g_dbus_dict_append_*()

 Makefile.obexd            |   1 -
 client/advertising.c      |  58 ++------------------
 client/main.c             | 100 +++-------------------------------
 gdbus/client.c            | 135 +++++++++++++++++++++++++++++++++-------------
 gdbus/gdbus.h             |   9 ++++
 mesh/main.c               | 100 +++-------------------------------
 obexd/client/dbus.c       |  94 --------------------------------
 obexd/client/dbus.h       |  48 -----------------
 obexd/client/ftp.c        |   7 ++-
 obexd/client/map.c        |   6 +--
 obexd/client/session.c    |   1 -
 obexd/client/transfer.c   |   1 -
 obexd/plugins/bluetooth.c |  40 ++------------
 src/dbus-common.c         |  85 +----------------------------
 src/dbus-common.h         |   6 ---
 src/device.c              |   3 +-
 tools/bluetooth-player.c  |  38 ++-----------
 tools/obexctl.c           |  36 +------------
 unit/test-gdbus-client.c  |  38 ++-----------
 19 files changed, 146 insertions(+), 660 deletions(-)
 delete mode 100644 obexd/client/dbus.c
 delete mode 100644 obexd/client/dbus.h

-- 
2.14.1


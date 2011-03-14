Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v3 0/5] Add new UUID utility functions and use them in GATT
Date: Mon, 14 Mar 2011 15:53:54 -0300
Message-Id: <1300128839-6293-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series creates new UUID utility functions and, at this momemt, puts
them into use in GATT/Low Energy code. Major differences between 'old'
and 'new' UUID functions are:

* UUID is stored in host order, and converted to/from network or
  Bluetooth order upon use.
* in bt_uuid{16,32,128}_create, raw numeric value (uint16, uint32 or
  uint128) is always passed by value.
* sdp_* prefix is replaced by bt_* for generality.

Types and macros needed by both "old" and "new" UUID functions as well as
their clients are moved to lib/bluetooth.h. This includes ntoh64(),
ntoh128() and friends.

Claudio Takahasi (1):
  Add new UUID utility functions

Elvis Pfützenreuter (4):
  Add more functions for new UUID handling
  Use new UUID functions in GATT
  Use new UUID functions in example GATT server
  Add "unit test" for new UUID functions

 Makefile.am          |    6 +-
 Makefile.tools       |    6 +-
 attrib/att.c         |   47 +++-----
 attrib/att.h         |   69 ++++++++++-
 attrib/client.c      |   26 ++---
 attrib/example.c     |   92 ++++++++-------
 attrib/gatt.c        |   68 ++++++-----
 attrib/gatt.h        |    4 +-
 attrib/gattrib.c     |    3 +-
 attrib/gatttool.c    |   18 ++--
 attrib/interactive.c |   22 ++--
 attrib/utils.c       |    1 +
 health/mcap_sync.c   |   15 ---
 lib/bluetooth.h      |   54 +++++++++
 lib/sdp.c            |   43 -------
 lib/sdp.h            |    4 +-
 lib/uuid.c           |  274 +++++++++++++++++++++++++++++++++++++++++++
 lib/uuid.h           |   65 ++++++++++
 src/adapter.c        |    1 +
 src/attrib-server.c  |   93 ++++++++-------
 src/attrib-server.h  |    4 +-
 src/device.c         |    1 +
 src/main.c           |    1 +
 test/hciemu.c        |   16 ---
 test/uuidtest.c      |  319 ++++++++++++++++++++++++++++++++++++++++++++++++++
 25 files changed, 971 insertions(+), 281 deletions(-)
 create mode 100644 lib/uuid.c
 create mode 100644 lib/uuid.h
 create mode 100644 test/uuidtest.c


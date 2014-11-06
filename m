Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/4] GAttrib cleanup and switch to bt_att
Date: Wed,  5 Nov 2014 18:15:07 -0800
Message-Id: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set cleans up gattrib and adds some missing functionality
to switch GAttrib to a shim on top of bt_att.  After this is merged,
profiles using GAttrib can be transitioned to bt_att.

v1 -> v2:
 * Keep old copyright on gattrib.c
 * Use 0x00 for sentinel value on BT_ATT_ALL_REQUESTS to futureproof

Michael Janssen (4):
  unit-gattrib: Fix uninitialized variable
  gattrib: Remove unused GATTRIB_ALL_EVENTS
  shared/att: Add support for BT_ATT_ALL_REQUESTS
  GATT shim to src/shared bt_att

 attrib/gattrib.c       | 734 ++++++++++---------------------------------------
 attrib/gattrib.h       |   1 -
 src/shared/att-types.h |   3 +
 src/shared/att.c       |  11 +-
 unit/test-gattrib.c    |  18 +-
 5 files changed, 160 insertions(+), 607 deletions(-)

-- 
2.1.2


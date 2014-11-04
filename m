Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/4] GAttrib cleanup and switch to bt_att
Date: Tue,  4 Nov 2014 13:19:55 -0800
Message-Id: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set cleans up gattrib and adds some missing functionality
to switch GAttrib to a shim on top of bt_att.  After this is merged,
profiles using GAttrib can be transitioned to bt_att.

Michael Janssen (4):
  unit-gattrib: Fix uninitialized variable
  gattrib: Remove unused GATTRIB_ALL_EVENTS
  shared/att: Add support for BT_ATT_ALL_REQUESTS
  GATT shim to src/shared bt_att

 attrib/gattrib.c       | 737 ++++++++++---------------------------------------
 attrib/gattrib.h       |   1 -
 src/shared/att-types.h |   3 +
 src/shared/att.c       |  11 +-
 unit/test-gattrib.c    |  18 +-
 5 files changed, 161 insertions(+), 609 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5


Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/7] Unit tests for GAttrib
Date: Fri, 24 Oct 2014 13:36:16 -0700
Message-Id: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since we want to replace GAttrib with a bt_att shim for a smooth transition 
to bt_att profiles, this patch cleans up the API and adds unit tests for
GAttrib functions.

This adds tests for all but the register / unregister functions, which
I will send in a separate patch since they are slightly more complicated due
to catchalls.

v1 -> v2:
 * Add g_attrib_register tests
 * Cleanup of unit/test-gattrib.c
 * Bugfix for GATTRIB_ALL_REQS

Michael Janssen (7):
  Remove unused g_attrib_set_debug function
  attrib: Remove MTU-probing code
  attrib: Add mtu argument to g_attrib_new
  attrib: remove g_attrib_is_encrypted
  Add unit tests for gattrib
  attrib: Add unit tests for g_attrib_register
  attrib: fix GATTRIB_ALL_REQS behavior

 .gitignore           |   1 +
 Makefile.am          |   7 +
 attrib/gattrib.c     |  61 +++----
 attrib/gattrib.h     |   7 +-
 attrib/gatttool.c    |  17 +-
 attrib/interactive.c |  17 +-
 src/attrib-server.c  |   9 +-
 src/device.c         |  11 +-
 unit/test-gattrib.c  | 505 +++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 588 insertions(+), 47 deletions(-)
 create mode 100644 unit/test-gattrib.c

-- 
2.1.0.rc2.206.gedb03e5


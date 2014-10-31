Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v5 0/8] Unit tests for gattrib API
Date: Fri, 31 Oct 2014 11:14:51 -0700
Message-Id: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
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

v2 -> v3:
  * Just move g_attrib_is_encrypted to static (Luiz)
  * Check that registered-for PDUs were delivered
  * Respond to Request PDU when registered for it.
  * Copy result PDUs since they aren't guaranteed to live beyond callback.

v3 -> v4:
  * Rework to use g_main_loop_run() for running
  * Reuse pdu_data struct in expect_response

v4 -> v5:
  * Rebase, fix compilation problems
  * Only init log on --verbose

Michael Janssen (8):
  attrib: Add mtu argument to g_attrib_new
  attrib: remove g_attrib_is_encrypted
  Add unit tests for gattrib
  attrib: Add unit tests for g_attrib_register
  attrib: fix GATTRIB_ALL_REQS behavior
  unit/gattrib: Check expected PDUs were delivered
  unit/gattrib: Respond to the request PDU.
  unit/gattrib: Only init log on --verbose

 .gitignore           |   1 +
 Makefile.am          |   7 +
 attrib/gattrib.c     |  44 ++--
 attrib/gattrib.h     |   4 +-
 attrib/gatttool.c    |  17 +-
 attrib/interactive.c |  17 +-
 src/attrib-server.c  |  12 ++
 src/device.c         |  11 +-
 unit/test-gattrib.c  | 576 +++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 664 insertions(+), 25 deletions(-)
 create mode 100644 unit/test-gattrib.c

-- 
2.1.0.rc2.206.gedb03e5


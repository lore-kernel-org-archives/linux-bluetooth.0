Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 00/18] GATT C API refactoring
Date: Tue,  2 Apr 2013 12:50:47 -0400
Message-Id: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

NOTE: This set is still in RFC state because it affects all LE profiles and we
have not tested them fully yet (just light testing on PTS for some procedures).
We plan to test most of the profile specific callbacks soon.

This patch set does some refactoring on the internal GATT API, by simplifying
the way the procedure callbacks are used:

* They do not receive raw ATT PDUs anymore. This removes a lot of duplicated
  parsing and validation of PDUs, and simplifies error handling.
* For "recursive" procedures (like characteristic/service discovery) it is now
  possible terminate the procedure early by returning "false" on the callback
  (as described on the Core spec). This can be used, for instance, when the
  user is only interested on a specific descriptor, like a Client
  Characteristic Configuration. An status error of ATT_ECODE_ATTR_NOT_FOUND
  indicates that the complete procedure has finished.

Some procedures have also been fixed as "side effect". This refactoring is a
preparation for a future (re-)implementation of the generic GATT D-Bus API.

TODO (before sending the final version):

* Write unit tests for all GATT procedures (in progress)
* Test LE profile implementations with devices we have (pending)
* Fix Read Characteristic by UUID. It is a recursive/iterative procedure, but
  BlueZ is not doing the recursion.
* A few more potential cleanups

For those who want to test this set, it depends on the "attrib: Replace GLib
basic data types usage" set sent by Jefferson Delfes last week, and on the 3
patches I sent a while ago.

Comments are welcome.

Anderson Lizardo (16):
  attrib: Avoid passing raw PDU to Exchange MTU callback
  unit: Add test for gatt_exchange_mtu()
  attrib: Rename gatt_find_info() to gatt_discover_char_desc()
  attrib: Modify gatt_cb_t to return bool
  unit: Add test for gatt_discover_primary()
  core: Refactor memory allocation for GATT service discovery
  core: Do not pass around memory allocated internally by GATT API
  attrib: Run callback with the partial result of service discovery
  core: Only do Find Included Services after receiving all GATT
    services
  attrib: Allow dec_read_resp() to just check if PDU is valid
  attrib: Avoid passing raw ATT PDU to gatt_read_char() callback
  attrib: Do not use Write Command in gatt_write_char()
  attrib: Fix coding style in prepare_write_cb()
  attrib: Simplify prepare_write()
  attrib: Avoid passing raw ATT PDU to gatt_write_char() callback
  attrib: Avoid passing raw PDU to gatt_discover_char_desc() callback

Eder Ruiz Maria (2):
  gatttool: Remove unused code
  gatt: Avoid passing raw PDU to read characteristic by UUID

 Makefile.am                          |    9 +
 attrib/att.c                         |    6 +-
 attrib/gatt.c                        |  366 ++++++++++++++++++++++++++++------
 attrib/gatt.h                        |   40 ++--
 attrib/gatttool.c                    |  114 ++++-------
 attrib/interactive.c                 |  158 +++++----------
 profiles/cyclingspeed/cyclingspeed.c |   87 +++-----
 profiles/deviceinfo/deviceinfo.c     |   20 +-
 profiles/gatt/gas.c                  |   82 +++-----
 profiles/heartrate/heartrate.c       |   66 +++---
 profiles/input/hog.c                 |  171 ++++++----------
 profiles/proximity/monitor.c         |   41 ++--
 profiles/scanparam/scan.c            |   72 +++----
 profiles/thermometer/thermometer.c   |  119 ++++-------
 src/device.c                         |   69 ++++---
 unit/test-gatt.c                     |  339 +++++++++++++++++++++++++++++++
 16 files changed, 1064 insertions(+), 695 deletions(-)
 create mode 100644 unit/test-gatt.c

-- 
1.7.9.5


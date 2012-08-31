Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 00/15] Unaligned memory access fixes
Date: Fri, 31 Aug 2012 10:36:10 +0200
Message-ID: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

A list of patches that address unaligned memory access issues all over
the code base.

It looks like recent versions of GCC are more picky about that. These
patches allow to build BlueZ in boostrap-configure configuration
(excluding gstreamer code) with GCC 4.7.1 for ARM.

In few places I had to do a small refactor instead of just use bt_put/get
functions. So please have a look at those.

There could be also bt_put_* functions added for putting u16/32/64 in
unaligned memory in host order. That could allow to eliminate some of
	memcpy(ptr, &some_u32, sizeof(some_u32);
with more convenient
	bt_put_32(some_u32, ptr);


Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (15):
  lib: Add host order unaligned access functions
  sap-u8500: Fix compile error due to unaligned memory access
  sdp: Use helper functions instead of bt_get_unaligned macro
  Add helper functions for putting integers on unaligned memory address
  sdp: Fix compilation errors due to unaligned memory access
  l2test: Fix compilation errors due to unaligned memory access
  rctest: Fix compilation errors due to unaligned memory access
  monitor: Fix compilation errors due to unaligned memory access
  scotest: Fix compilation errors due to unaligned memory access
  avrcp: Fix compilation errors due to unaligned memory access
  sap: Fix compilation errors due to unaligned memory access
  adaptername: Refactor handle_inotify_cb
  sdpd-request: Fix build errors due to unaligned memory access
  sdpd-service: Fix build errors due to unaligned memory access
  hciemu: Fix build errors due to unaligned memory access

 audio/avrcp.c            |   10 ++---
 lib/bluetooth.h          |   76 +++++++++++++++++++++++++++++++++++++
 lib/sdp.c                |   94 ++++++++++++++++++++++++----------------------
 monitor/control.c        |    7 +++-
 monitor/hcidump.c        |   23 ++++++++----
 plugins/adaptername.c    |   44 ++++++++++++----------
 profiles/sap/sap-u8500.c |   10 +++--
 profiles/sap/server.c    |    9 ++---
 src/sdpd-request.c       |   62 ++++++++++++++++--------------
 src/sdpd-service.c       |   21 +++++------
 test/hciemu.c            |    6 ++-
 test/l2test.c            |    9 +++--
 test/rctest.c            |    5 ++-
 test/scotest.c           |    5 ++-
 14 files changed, 243 insertions(+), 138 deletions(-)

-- 
1.7.9.5


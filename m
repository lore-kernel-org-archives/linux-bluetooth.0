Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/7] RFC: proximity cleanup
Date: Fri, 31 Aug 2012 14:48:26 +0200
Message-ID: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are few patches to cleanup proximity profile code a bit which seem to
keep track of some data which are redundant and has minor issue with device
driver registration.

Most cleanup is done in patch #3 which removes tracking of DBusConnection
across whole plugin and simply uses get_dbus_connection() wherever necessary.
This is different than other profile plugins do, but reduces code size and
memory footprint a bit so can be done for other plugins as well if accepted.


Andrzej Kaczmarek (7):
  proximity: Change adapter driver function names
  proximity: Remove unused definitions
  proximity: Simplify DBusConnection object usage
  proximity: Move reporter device driver registration to manager
  proximity: Remove unnecessary check for GATT enabled
  proximity: Remove list of adapter devices
  proximity: Remove reporter_adapter

 profiles/proximity/immalert.c |   9 +---
 profiles/proximity/immalert.h |   2 +-
 profiles/proximity/linkloss.c |  10 +---
 profiles/proximity/linkloss.h |   2 +-
 profiles/proximity/main.c     |  10 +---
 profiles/proximity/manager.c  |  38 +++++++++-----
 profiles/proximity/manager.h  |   2 +-
 profiles/proximity/monitor.c  |  20 ++++----
 profiles/proximity/monitor.h  |   8 +--
 profiles/proximity/reporter.c | 115 +++++-------------------------------------
 profiles/proximity/reporter.h |   7 ++-
 11 files changed, 62 insertions(+), 161 deletions(-)

-- 
1.7.11.3


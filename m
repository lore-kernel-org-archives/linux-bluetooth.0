Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/8] decoupling adapter code from sdp
Date: Thu, 19 Sep 2013 16:00:40 +0200
Message-ID: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This includes code removal from sdptool that is no longer fully usable
with this serie.

Since Marcel had some objections about Device ID plugin patch it is moved
to end to not interfere with rest of patches. This plugin now also handles
setting proper DID values to adapter. Yet, main_opts are still accessed
directly and that should be worked out later.

With those patches sdp server is fully controlled by adapters and there
is no mutual adapter<->sdp code invocations.

BR
Szymon

Szymon Janc (8):
  adapter: Insert DeviceID record if setting DeviceID data to controller
  adapter: Handle adding new SDP records
  adapter: Handle removing of SDP records
  Remove not needed sdp_init_services_list function
  unit: Remove not needed functions from test-sdp
  sdpd: Remove 'register' and 'remove' requests
  sdptool: Remove support for adding and removing service records
  sdp: Decouple Device ID profile implementation

 Makefile.plugins             |    3 +
 plugins/gatt-example.c       |    2 +-
 profiles/audio/a2dp.c        |   14 +-
 profiles/audio/avrcp.c       |    8 +-
 profiles/deviceid/deviceid.c |  187 +++
 profiles/health/hdp.c        |    2 +-
 profiles/health/hdp_util.c   |    6 +-
 profiles/network/server.c    |    6 +-
 profiles/sap/server.c        |    4 +-
 src/adapter.c                |   59 +-
 src/adapter.h                |    8 +-
 src/attrib-server.c          |   12 +-
 src/attrib-server.h          |    2 +-
 src/profile.c                |    9 +-
 src/sdpd-database.c          |   41 -
 src/sdpd-request.c           |   14 -
 src/sdpd-server.c            |    4 -
 src/sdpd-service.c           |  158 ---
 src/sdpd.h                   |    6 -
 tools/sdptool.1              |   16 -
 tools/sdptool.c              | 2595 +-----------------------------------------
 unit/test-sdp.c              |   29 -
 22 files changed, 321 insertions(+), 2864 deletions(-)
 create mode 100644 profiles/deviceid/deviceid.c

-- 
1.8.4


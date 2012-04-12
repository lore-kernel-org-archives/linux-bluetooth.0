Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 00/19] Fix D-Bus memory leaks, bluetooth name,
 double unref etc
Date: Thu, 12 Apr 2012 20:32:51 +0530
Message-id: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches fixes the following issues.

Syam Sidhardhan (19):
  health: Fix memory leak
  avrcp: Fix the response ctype of SetPlayerApplicationSettingValue
  agent: Free the agent request properly
  gstavdtpsink: Fix D-Bus memory leak in audio
  gateway: Fix D-Bus memory leak in audio
  gateway: Fix D-Bus reply memory leak
  hci: Retrieve the bluetooth name correctly
  hciconfig: Remove unwanted NULL termination
  agent: Fix double D-Bus message unref
  sdpd-request: Fix passing zero instead of NULL
  sap-u8500: Fix empty parameter list in function declaration
  adapter: Remove headers declared but not defined
  headset: Remove header declared but not defined
  network: Remove header declared but not defined
  audio: Fix newline before EOF
  input: Fix newline before EOF
  src: Fix newline before EOF
  doc: Fix typo
  Add Syam's email address

 AUTHORS              |    1 +
 audio/avrcp.c        |    2 +-
 audio/gateway.c      |   11 +++++++----
 audio/gsta2dpsink.c  |    1 -
 audio/gsta2dpsink.h  |    1 -
 audio/gstavdtpsink.c |    4 +++-
 audio/gstrtpsbcpay.c |    1 -
 audio/gstsbcdec.c    |    2 --
 audio/gstsbcenc.c    |    2 --
 audio/gstsbcparse.c  |    1 -
 audio/gstsbcutil.c   |    1 -
 audio/gstsbcutil.h   |    1 -
 audio/headset.h      |    1 -
 doc/adapter-api.txt  |    2 +-
 doc/audio-api.txt    |    2 +-
 doc/device-api.txt   |    2 +-
 doc/health-api.txt   |    6 +++---
 doc/media-api.txt    |    6 +++---
 doc/mgmt-api.txt     |    2 +-
 doc/serial-api.txt   |    2 +-
 health/mcap.c        |    1 +
 input/sixpair.c      |    1 -
 lib/hci.c            |    5 +++--
 network/server.h     |    2 --
 sap/sap-u8500.c      |    2 +-
 src/adapter.h        |    2 --
 src/agent.c          |    3 +--
 src/agent.h          |    1 -
 src/log.h            |    1 -
 src/sdp-client.c     |    1 -
 src/sdpd-request.c   |    2 +-
 src/storage.h        |    1 -
 tools/hciconfig.c    |    2 --
 33 files changed, 30 insertions(+), 45 deletions(-)

-- 
1.7.4.1


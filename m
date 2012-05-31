Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 00/14] Prefer PAN over DUN
Date: Thu, 31 May 2012 15:43:24 +0200
Message-Id: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

This version moves the UUID strings into the lib instead of the core.
I tried to do get rid of the UUID string using the *_SVCLASS_ID from sdp.h
but it is hard to do string magic during precompile time...

cheers,
daniel

changes:

v3: - Move UUID strings into lib

v2: - Move all UUID string definition into one header file
    - Change configuration variable name
    - This behavior is off by default

Daniel Wagner (14):
  sdp: Remove unused BASE_UUID definition
  audio: Move UUID string definition to lib
  network: Move UUID string definition to lib
  deviceinfo: Move UUID string definition to lib
  proximity: Move UUID string definition to lib
  sap: Move UUID string definition to lib
  thermometer: Move UUID string definition to lib
  serial: Move UUID string definition to lib
  health: Move UUID string definition to lib
  input: Move UUID string definition to lib
  pnat: Move UUID string definition to lib
  core: Move UUID string definition to lib
  main: Add PreferPANoverDUN configuration switch
  device: Ignore DUN if PAN is present

 audio/avctp.c             |    1 +
 audio/avdtp.c             |    1 +
 audio/avrcp.c             |    1 +
 audio/device.h            |   16 --------------
 audio/manager.c           |    1 +
 audio/media.c             |    2 ++
 audio/transport.c         |    2 ++
 deviceinfo/deviceinfo.c   |    2 --
 deviceinfo/manager.c      |    2 --
 health/hdp_manager.c      |    1 +
 health/hdp_types.h        |    4 ----
 health/hdp_util.c         |    1 +
 input/device.c            |    1 +
 input/device.h            |    3 ---
 input/manager.c           |    1 +
 input/server.c            |    1 +
 lib/sdp.c                 |    2 --
 lib/uuid.h                |   51 +++++++++++++++++++++++++++++++++++++++++++++
 network/common.c          |    1 +
 network/common.h          |    5 -----
 network/manager.c         |    1 +
 network/server.c          |    1 +
 plugins/pnat.c            |    4 ++--
 proximity/manager.c       |    4 ----
 proximity/reporter.c      |    2 --
 sap/server.c              |    2 +-
 serial/manager.c          |    3 +--
 src/device.c              |   19 ++++++++++++++++-
 src/hcid.h                |    1 +
 src/main.c                |    8 +++++++
 src/main.conf             |    5 +++++
 src/storage.c             |    1 +
 src/storage.h             |    2 --
 thermometer/manager.c     |    2 --
 thermometer/thermometer.c |    5 -----
 35 files changed, 104 insertions(+), 55 deletions(-)

-- 
1.7.10.130.g36e6c


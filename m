Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 00/15]  Prefer PAN over DUN
Date: Wed, 30 May 2012 14:59:53 +0200
Message-Id: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

the first part of the series moves the UUID string definition into a
new header file inside the core. With this the last patch doesn't have
to include profile header files.

I did not order the defintion or 'improve' them in anyway. If this
approach is okay, I would suggest to add more patches on top of them
in order not to mix the moving and the 'improving' in one go.

cheers,
daniel

changes:

v2: - Move all UUID string definition into one header file
    - Change configuration variable name
    - This behavior is off by default

Daniel Wagner (15):
  sdp: Remove unused BASE_UUID definition
  audio: Move UUID defintion to core
  network: Move UUID defintion to core
  deviceinfo: Move UUID defintion to core
  proximity: Move UUID defintion to core
  sap: Move UUID definition to core
  thermometer: Move UUID definition to core
  serial: Move UUID defintion to core
  health: Move UUID defintion to core
  input: Move UUID defintion to core
  pnat: Move UUID defintion to core
  device: Move UUID definition to uuid.h
  storage: Move UUID defintion to uuid.h
  main: Add PreferPANoverDUN configuration switch
  device: Ignore DUN if PAN is present

 Makefile.am               |    3 +-
 audio/avctp.c             |    1 +
 audio/avdtp.c             |    1 +
 audio/avrcp.c             |    1 +
 audio/device.h            |   16 ----------
 audio/manager.c           |    1 +
 audio/media.c             |    1 +
 audio/transport.c         |    1 +
 deviceinfo/deviceinfo.c   |    4 +--
 deviceinfo/manager.c      |    4 +--
 health/hdp_manager.c      |    2 ++
 health/hdp_types.h        |    4 ---
 health/hdp_util.c         |    2 ++
 input/device.c            |    1 +
 input/device.h            |    3 --
 input/manager.c           |    1 +
 input/server.c            |    1 +
 lib/sdp.c                 |    2 --
 network/common.c          |    2 ++
 network/common.h          |    5 ----
 network/manager.c         |    2 ++
 network/server.c          |    1 +
 plugins/pnat.c            |    5 ++--
 proximity/manager.c       |    6 ++--
 proximity/reporter.c      |    4 +--
 sap/server.c              |    3 +-
 serial/manager.c          |    3 +-
 src/device.c              |   20 ++++++++++++-
 src/hcid.h                |    1 +
 src/main.c                |    8 +++++
 src/main.conf             |    5 ++++
 src/storage.c             |    1 +
 src/storage.h             |    2 --
 src/uuid.h                |   73 +++++++++++++++++++++++++++++++++++++++++++++
 thermometer/manager.c     |    4 +--
 thermometer/thermometer.c |    7 ++---
 36 files changed, 145 insertions(+), 56 deletions(-)
 create mode 100644 src/uuid.h

-- 
1.7.10.130.g36e6c


Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 00/11] struct btd_service in core
Date: Tue, 26 Mar 2013 17:13:43 +0100
Message-Id: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v1 integrates Johan's feedback, mainly:
- All functions and types in service.h prefixed with btd_.
- const qualifier used where possible.
- Add function state2str() instead of using table.
- Avoid using GPOINTER_TO_INT() to pass enum and instead write a find function.

>From original cover-letter:

This RFC proposes a somewhat intrusive change in the core with the adoption of struct btd_service, with the following main goals:

1. Support for multiple instances of the same UUID.
2. Better support for connection-handling plugins/components (e.g. automotive).
3. Exposure of remote services in D-Bus (not implemented here).
4. Improve code readability and reduce profile-implementation code size.

Mikel Astiz (11):
  core: Add btd_service to represent device services
  device: Use btd_service to represent profiles
  device: Replace connected_profiles with btd_service
  device: Find services instead of profiles
  device: Replace pending profile list with services
  profile: Use btd_service for probing profiles
  audio: Hold a reference to btd_service
  network: Hold a reference to btd_service
  input: Hold a reference to btd_service
  service: Add callbacks to track state changes
  profile: Use btd_service for connect/disconnect

 Makefile.am                          |   1 +
 Makefile.plugins                     |   4 +-
 profiles/audio/control.c             |  52 +++++--
 profiles/audio/control.h             |   7 +-
 profiles/audio/manager.c             |  80 ++++-------
 profiles/audio/manager.h             |   7 -
 profiles/audio/sink.c                |  24 ++--
 profiles/audio/sink.h                |   4 +-
 profiles/audio/source.c              |  25 ++--
 profiles/audio/source.h              |   5 +-
 profiles/cyclingspeed/cyclingspeed.c |   9 +-
 profiles/deviceinfo/deviceinfo.c     |  11 +-
 profiles/gatt/gas.c                  |  10 +-
 profiles/health/hdp_manager.c        |  10 +-
 profiles/heartrate/heartrate.c       |  10 +-
 profiles/input/device.c              |  95 +++++++------
 profiles/input/device.h              |  13 +-
 profiles/input/hog.c                 |   8 +-
 profiles/input/manager.c             |  51 +------
 profiles/input/manager.h             |  25 ----
 profiles/network/connection.c        |  77 ++++++-----
 profiles/network/connection.h        |   8 +-
 profiles/network/manager.c           | 123 ++---------------
 profiles/network/manager.h           |  25 ----
 profiles/proximity/manager.c         |  28 ++--
 profiles/proximity/reporter.c        |   8 +-
 profiles/proximity/reporter.h        |   5 +-
 profiles/sap/manager.c               |   1 +
 profiles/scanparam/scan.c            |   9 +-
 profiles/thermometer/thermometer.c   |  11 +-
 src/device.c                         | 242 +++++++++++++++++++++-----------
 src/device.h                         |   5 -
 src/profile.c                        |  40 ++++--
 src/profile.h                        |  14 +-
 src/service.c                        | 260 +++++++++++++++++++++++++++++++++++
 src/service.h                        |  61 ++++++++
 36 files changed, 813 insertions(+), 555 deletions(-)
 delete mode 100644 profiles/input/manager.h
 delete mode 100644 profiles/network/manager.h
 create mode 100644 src/service.c
 create mode 100644 src/service.h

-- 
1.8.1.4


Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 00/27] struct btd_service in core
Date: Fri, 26 Apr 2013 08:16:56 +0200
Message-Id: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

I promote this to PATCH instead of RFC considering that Johan's feedback to RFC v2 was farily positive.

The patchset has now been reworked with the aim to make the review easier, while some of the patches are still quite big and unavoidably sparse. The non-trivial changes have been split to separate patchset and the ones not stricly related to btd_service have been moved to the front (first 10 patches).

Besides that, v3 includes:
- btd_service ownership by btd_device, as suggested by Johan. This means the btd_service instance holds a weak reference to btd_device (no reference counting).
- All btd_profile callback handling moved now to service.c, improving the API in service.h (with "active" functions such as btd_service_connect() etc. instead of the former state-propagation functions).

Cheers,
Mikel

Mikel Astiz (27):
  device: Fix returned error code
  control: Simplify UUID handling during probe
  input: Simplify code since UUID is known
  profile: Remove UUID list from probe function
  network: Fail if multiple profile instances
  input: Fix ignored profile shutdown
  input: Move timeout setting to device.c
  input: Remove unused UUID field
  input: Bypass manager during probe/remove
  network: Bypass manager during probe/remove
  core: Add btd_service to represent device services
  device: Use btd_service to represent profiles
  core: Add probe API to btd_service
  core: Add connect/disconnect API to btd_service
  core: Add a state enum to btd_service
  device: Replace connected_profiles with btd_service
  device: Find services instead of profiles
  device: Replace pending profile list with services
  profile: Use btd_service for probing profiles
  network: Add trivial helper function
  core: Add user_data to btd_service
  network: Hold a reference to btd_service
  audio: Hold a reference to btd_service
  control: Bypass manager for connect state changes
  input: Hold a reference to btd_service
  service: Add callbacks to track state changes
  profile: Use btd_service for connect/disconnect

 Makefile.am                          |   1 +
 Makefile.plugins                     |   4 +-
 profiles/audio/avrcp.c               |  16 +-
 profiles/audio/control.c             |  48 ++++-
 profiles/audio/control.h             |  12 +-
 profiles/audio/manager.c             |  88 +++------
 profiles/audio/manager.h             |   9 -
 profiles/audio/sink.c                |  24 +--
 profiles/audio/sink.h                |   4 +-
 profiles/audio/source.c              |  25 +--
 profiles/audio/source.h              |   5 +-
 profiles/cyclingspeed/cyclingspeed.c |   9 +-
 profiles/deviceinfo/deviceinfo.c     |  11 +-
 profiles/gatt/gas.c                  |  10 +-
 profiles/health/hdp_manager.c        |  10 +-
 profiles/heartrate/heartrate.c       |  10 +-
 profiles/input/device.c              |  87 +++++----
 profiles/input/device.h              |  13 +-
 profiles/input/hog.c                 |   8 +-
 profiles/input/manager.c             |  51 +-----
 profiles/input/manager.h             |  25 ---
 profiles/network/connection.c        |  75 ++++----
 profiles/network/connection.h        |   8 +-
 profiles/network/manager.c           | 123 ++-----------
 profiles/network/manager.h           |  25 ---
 profiles/proximity/manager.c         |  28 +--
 profiles/proximity/reporter.c        |   8 +-
 profiles/proximity/reporter.h        |   5 +-
 profiles/sap/manager.c               |   1 +
 profiles/scanparam/scan.c            |   9 +-
 profiles/thermometer/thermometer.c   |  11 +-
 src/device.c                         | 244 +++++++++++++------------
 src/device.h                         |   7 -
 src/profile.c                        |  40 +++--
 src/profile.h                        |  14 +-
 src/service.c                        | 338 +++++++++++++++++++++++++++++++++++
 src/service.h                        |  68 +++++++
 37 files changed, 875 insertions(+), 599 deletions(-)
 delete mode 100644 profiles/input/manager.h
 delete mode 100644 profiles/network/manager.h
 create mode 100644 src/service.c
 create mode 100644 src/service.h

-- 
1.8.1.4


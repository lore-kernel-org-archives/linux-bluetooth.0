Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 00/16] Introduce btd_server
Date: Tue, 25 Jun 2013 18:24:33 +0200
Message-Id: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This RFC presents a proposal to extend the BlueZ core to simplify the implementation of profiles. It introduces a new core concept (btd_server) as a first step towards providing internal infrastructure in a similar way that external profiles have. This exact purpose of the new struct is described in patch 01.

Currently, it's paradoxical that externally implemented profiles are in a way simpler to implement. There is a lot of helpful code in profile.c which could be reused for internal profiles too.

This first patchset consists of three main parts:
1. The extension of the core (patches 01..03).
2. Some simple examples of adoption (patches 04..10).
3. A more complex adoption (patches 11..16).

This part is fairly simple and doesn't offer great benefits besides the usage of the userdata pointer in btd_server, which can already be handy (see for example 08/16).

Furhter and more interesting changes in the pipeline (but not submitted in v0) include:
4. Handling of incoming connections.
5. Integration with agent authorization.
6. Adoption of new infrastructure for external profiles.

For the record, the result of this whole work does not add more lines of code to maintain, it just moves the code complexity from profile implementations to the core. The result is less duplicated code and data throughout the codebase, hopefully leading to more robust profiles.

Mikel Astiz (16):
  core: Add btd_server
  adapter: Create btd_server instances when probing
  profile: Use btd_server to probe adapters
  input: Bypass manager for profile server
  input: Use btd_server userdata for input_server
  thermometer: Remove boilerplate code
  thermometer: Use btd_server userdata
  cyclingspeed: Use btd_server userdata
  heartrate: Remove boilerplate code
  heartrate: Use btd_server userdata
  network: Replace list with network_adapter
  network: Bypass manager for profile server
  network: Simplify search-by-UUID
  network: Add a dedicated btd_profile for BNEP
  network: Create network_adapter during BNEP probe
  network: Use btd_server userdata for network_server

 Makefile.am                          |   1 +
 profiles/alert/server.c              |   9 +-
 profiles/audio/manager.c             |  41 +++++---
 profiles/cyclingspeed/cyclingspeed.c |  38 +++----
 profiles/health/hdp_manager.c        |  11 ++-
 profiles/heartrate/heartrate.c       |  51 +++-------
 profiles/input/manager.c             |  12 +--
 profiles/input/server.c              |  28 ++----
 profiles/input/server.h              |   4 +-
 profiles/network/manager.c           |  76 ++------------
 profiles/network/server.c            | 185 +++++++++++++++--------------------
 profiles/network/server.h            |   8 +-
 profiles/proximity/reporter.c        |   8 +-
 profiles/proximity/reporter.h        |   5 +-
 profiles/sap/manager.c               |   9 +-
 profiles/thermometer/thermometer.c   |  82 ++++------------
 profiles/time/server.c               |   8 +-
 src/adapter.c                        |  50 +++++-----
 src/adapter.h                        |   2 +
 src/profile.c                        |  11 ++-
 src/profile.h                        |   7 +-
 src/server.c                         | 108 ++++++++++++++++++++
 src/server.h                         |  38 +++++++
 23 files changed, 389 insertions(+), 403 deletions(-)
 create mode 100644 src/server.c
 create mode 100644 src/server.h

-- 
1.8.1.4


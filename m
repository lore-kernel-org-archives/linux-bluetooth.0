Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 00/15] WIP: btd_profile connect and disconnect
Date: Fri, 19 Oct 2012 17:39:17 +0200
Message-Id: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This RFC is work-in-progress: the patches are not intended to be applied, but instead submitted as a base for discussion.

The patchset proposes three inter-related changes:

(1) Splitting of individual btd_profile instantes per role. Some profiles do already have such separation (see HFP-Gateway) but some others have all roles merged into one (see A2DP or PAN).

(2) Exposure of internal APIs to connect/disconnect devices, as proposed by the btd_profile approach (.connect and .disconnect). The goal would be not only to support Device.Connect, but also to be able to implement connection-handling plugins such as the IVI case.

(3) The exposure of a D-Bus API to connect/disconnect profiles, and report the current state (disconnected, connecting, or connected). The goal here would be to be able to implement Bluetooth-centric UIs, which typically show which profiles have been connected per device. Additionally, this would allow implementing connection-handling policies externally, instead of in a plugin.

Each of this point requires some discussion. For example, in point (2), there are different possible way to expose an internal API to connect/disconnect profiles. The patchset, in fact, proposes different approaches for HID (patch 08/15), where it's btd_profile-aware, or networking (patch 03/15), where the internal API has nothing to do with the btd_profile infrastructure.

The D-Bus API could have several variants as well, one of them being the currently existing one in BlueZ 4.x. This first RFC proposes a completely different one, based on a new D-Bus interface (org.bluez.Profile, see patch 15/15), which is admittedly ugly.

I hope some of this ideas can make sense for BlueZ 5.

Any feedback will be welcome,

Mikel

Mikel Astiz (15):
  network: Specify id while registering server
  network: Trivial function rename
  network: Expose internal connection API
  network: Split Network into three btd_profile
  network: Add network .connect and .disconnect
  audio: Split A2DP into three btd_profile
  audio: Trivial function rename
  source: Expose internal connection API
  source: Add profile .connect and .disconnect
  input: Trivial function rename
  input: Expose internal disconnection API
  input: Add profile .disconnect
  profile: Rename org.bluez.Profile->ProfileAgent
  profile: Add object to represent device-profile
  profile: Add new org.bluez.Profile

 Makefile.am                   |   1 +
 audio/a2dp.c                  |  88 ++++++-------
 audio/a2dp.h                  |   4 +-
 audio/device.h                |   3 +
 audio/manager.c               | 185 ++++++++++++++++++++++++---
 audio/sink.c                  |  12 +-
 audio/source.c                | 158 +++++++++++++----------
 audio/source.h                |   2 +
 doc/device-api.txt            |  23 ----
 doc/manager-api.txt           |   3 +-
 doc/profile-api.txt           |  59 ++++-----
 doc/profileagent-api.txt      |  53 ++++++++
 profiles/input/device.c       |  39 ++++--
 profiles/input/device.h       |   6 +-
 profiles/input/manager.c      |   1 +
 profiles/network/connection.c | 160 +++++++++++++++--------
 profiles/network/connection.h |   8 ++
 profiles/network/manager.c    | 205 +++++++++++++++++++++++++++---
 profiles/network/server.c     |   9 +-
 profiles/network/server.h     |   4 +-
 src/bluetooth.conf            |   2 +-
 src/device-profile.c          | 288 ++++++++++++++++++++++++++++++++++++++++++
 src/device-profile.h          |  43 +++++++
 src/device.c                  | 110 +++++++++++-----
 src/manager.c                 |   2 +-
 src/profile.c                 |  56 ++++----
 src/profile.h                 |  11 +-
 test/test-profile             |   8 +-
 28 files changed, 1191 insertions(+), 352 deletions(-)
 create mode 100644 doc/profileagent-api.txt
 create mode 100644 src/device-profile.c
 create mode 100644 src/device-profile.h

-- 
1.7.11.7


Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 00/16] Move storage config and names files to ini-file format
Date: Wed, 24 Oct 2012 16:34:02 +0200
Message-Id: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/settings
in ini-file format for BlueZ 5.
Devices name cache will be saved in 1 file per device (named by device address)
under /var/lib/bluetooth/<adapter address>/cache/ directory.
If this files does not exist, we try to convert legacy files to this new format.

Access to variables during run-time is performed in adapter structure which is
populated by loading saved configuration during initialization.

Patches 2 to 8 remove access to config file from run-time.
Patch 9 moves to ini-file format style (load, save and convert).
Patches 11 to 16 move devices name cache to new files (read, write and convert).

Frédéric Danis (16):
  doc: Add settings storage documentation
  adapter: Read name in storage at init
  adaptername: Retrieve config name from adapter
  adapter: Remove device class storage
  adapter: Move pairable read to load_config()
  adapter: Read pairable timeout in storage at init
  adapter: Read discoverable timeout in storage at init
  adapter: Read mode in storage at init
  adapter: Move saved config to ini-file format
  TODO: Add entry to remove storage convertion function
  adapter: Move storage names to cache directory
  event: Remove write of LastSeen info
  device: Retrieve name from cache directory
  dbusoob: Store device name in cache directory
  input: Retrieve device name from cache directory
  hcitool: Retrieve names from cache directory

 Makefile.tools           |    2 +-
 TODO                     |    6 +
 doc/settings-storage.txt |  183 ++++++++++++++++++++++
 plugins/adaptername.c    |    6 +-
 plugins/dbusoob.c        |   26 +++-
 plugins/neard.c          |    2 +-
 profiles/input/device.c  |   26 +++-
 src/adapter.c            |  387 +++++++++++++++++++++++++++++++++++-----------
 src/adapter.h            |    3 +-
 src/device.c             |   25 ++-
 src/event.c              |   37 +++--
 src/mgmt.c               |   19 +--
 src/mgmt.h               |    1 +
 tools/hcitool.c          |   31 +++-
 14 files changed, 615 insertions(+), 139 deletions(-)
 create mode 100644 doc/settings-storage.txt

-- 
1.7.9.5


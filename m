Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/11] code: Add support for Advertisement Data
Date: Wed, 15 Apr 2015 14:44:17 +0300
Message-Id: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for ServiceData and ManufacturerData and make the
necessary to bluetoothctl to print them:

[bluetooth]# info XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX
	Alias: XX-XX-XX-XX-XX-XX
	Paired: no
	Trusted: no
	Blocked: no
	Connected: no
	LegacyPairing: no
	ManufacturerData Key: 0x004c
	ManufacturerData Value: 0x0c
	ManufacturerData Value: 0x0e
	ManufacturerData Value: 0x00
	ManufacturerData Value: 0xf1
	ManufacturerData Value: 0xa6
	ManufacturerData Value: 0xdc
	ManufacturerData Value: 0xa1
	ManufacturerData Value: 0xc0
	ManufacturerData Value: 0x51
	ManufacturerData Value: 0x80
	ManufacturerData Value: 0xa7
	ManufacturerData Value: 0x83
	ManufacturerData Value: 0x62
	ManufacturerData Value: 0x95
	ManufacturerData Value: 0x18
	ManufacturerData Value: 0x79

Currently the data is not stored persistently since it may change over
time, but it should be relatively easy to change that in case we want to
persist the information over restart/reboot.

Luiz Augusto von Dentz (11):
  doc/device-api: Add ServiceData and ManufacturerData
  shared/ad: Add bt_ad_foreach_manufacturer_data
  shared/ad: Add bt_ad_has_manufacturer_data
  core/dbus-common: Add dict helpers for basic keys
  core: Add implementation of ManufacturerData
  client: Fix no handling dict properly
  client: Make command info print ManufacturerData
  shared/ad: Add bt_ad_foreach_service_data
  shared/ad: Add bt_ad_has_service_data
  core: Add implementation of ServiceData
  client: Make command info print ServiceData

 client/main.c      |  12 ++++-
 doc/device-api.txt |  11 +++++
 src/adapter.c      |   4 +-
 src/dbus-common.c  |  27 ++++++++---
 src/dbus-common.h  |   5 ++
 src/device.c       | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   2 +
 src/shared/ad.c    | 120 ++++++++++++++++++++++++++++++++++++----------
 src/shared/ad.h    |  26 ++++++++++
 9 files changed, 309 insertions(+), 35 deletions(-)

-- 
2.1.0


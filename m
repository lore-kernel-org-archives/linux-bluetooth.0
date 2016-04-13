Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v6 0/5] Couple fixes and improvements
Date: Wed, 13 Apr 2016 23:09:52 +0200
Message-Id: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've back to work on making Android gatt to make use of shared/gatt.
Here is couple of fixes I've done to shared code when doing this work.

Android gatt still needs testing but will be available sooner or later

v2:
 - fix test-gatt for long write seesion testes
 - prepare test-gatt test to support other changes
 - do aggregation of prep writes for long write session
 - support reliable nested long write
 - start to look into characteristic extended prop for reliable session

v3:
 - rebase
 - remove patch adding notification type - that one needs to be reworked

v4:
 - Fix according to Luiz comment

v5:
 - Fix additional Luiz comments

v6:
 - move getting extended properties to gatt_db_attribute_get_char_data instead
of separate API
 - added patch which read extended characteristic propertis descriptors
   during discovery session when acting as gatt-client. This is needed so
   the call of gatt_db_attribute_get_char_data will return correct ext_prop value.
 - Added patch fixing charcteristic properties in btgatt-server and test-gatt


Łukasz Rymanowski (5):
  btgatt-server: Fix GATT device name properties
  test-gatt: Fix characteristic properties
  shared/gatt-db: Extend gatt_db_attribute_get_char_data with ext. prop
  shared/gatt-server Check for ext. charact. prop. on reliable session
  gatt-client: Read extended props on service discovery

 profiles/deviceinfo/deviceinfo.c |   2 +-
 profiles/gap/gas.c               |   2 +-
 profiles/scanparam/scan.c        |   2 +-
 src/device.c                     |   2 +-
 src/gatt-client.c                |   3 +-
 src/shared/gatt-client.c         | 120 ++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-db.c             |  63 ++++++++++++++++++++
 src/shared/gatt-db.h             |   1 +
 src/shared/gatt-server.c         |  50 +++++++++++++++-
 tools/btgatt-client.c            |   8 ++-
 tools/btgatt-server.c            |  11 ++--
 unit/test-gatt.c                 |  41 +++++++++----
 12 files changed, 278 insertions(+), 27 deletions(-)

-- 
2.5.0


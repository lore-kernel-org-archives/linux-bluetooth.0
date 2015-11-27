Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 00/11] shared/gatt: Couple fixes and improvements
Date: Fri, 27 Nov 2015 12:11:39 +0100
Message-Id: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
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

Łukasz Rymanowski (11):
  unit/test-gatt: Fix long write testcases
  unit/test-gatt: Modify small-db
  unit/test-gatt: Extend large-db
  unit/test-gatt: Fix long write test
  shared/gatt-client: Minor variable rename
  shared/gatt-client: Add notify type to notification callback
  shared/gatt-server: Fix handle error on execute write
  shared/gatt-server: Add support for long write
  shared/gatt-server: Support for reliable session nested with long
  shared/gatt-db: Add API to get extended prop
  shared/gatt-server: Check for ext. charact. prop. on reliable session

 profiles/scanparam/scan.c |   5 +-
 src/gatt-client.c         |   4 +-
 src/shared/gatt-client.c  |  13 ++--
 src/shared/gatt-client.h  |  13 +++-
 src/shared/gatt-db.c      |  62 +++++++++++++++++
 src/shared/gatt-db.h      |   4 ++
 src/shared/gatt-server.c  | 169 ++++++++++++++++++++++++++++++++++++++++------
 tools/btgatt-client.c     |   2 +-
 unit/test-gatt.c          | 113 +++++++++++++++++++------------
 9 files changed, 309 insertions(+), 76 deletions(-)

-- 
2.5.0


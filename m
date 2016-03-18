Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v3 0/9] shared/gatt: Couple fixes and improvements 
Date: Fri, 18 Mar 2016 14:08:09 +0100
Message-Id: <1458306498-28151-1-git-send-email-lukasz.rymanowski@codecoup.pl>
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

Łukasz Rymanowski (9):
  unit/test-gatt: Fix long write testcases
  unit/test-gatt: Modify small-db
  unit/test-gatt: Extend large-db
  unit/test-gatt: Fix long write test
  shared/gatt-server: Fix handle error on execute write
  shared/gatt-server: Add support for long write
  shared/gatt-server: Support for reliable session nested with long
  shared/gatt-db: Add API to get extended prop
  shared/gatt-server: Check for ext. charact. prop. on reliable session

 src/shared/gatt-db.c     |  62 ++++++++++++++++++
 src/shared/gatt-db.h     |   4 ++
 src/shared/gatt-server.c | 163 +++++++++++++++++++++++++++++++++++++++++------
 unit/test-gatt.c         |  99 +++++++++++++++++-----------
 4 files changed, 271 insertions(+), 57 deletions(-)

-- 
2.5.0


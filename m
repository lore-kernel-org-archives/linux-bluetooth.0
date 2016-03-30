Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v4 0/3] shared/gatt: Couple fixes and improvements
Date: Wed, 30 Mar 2016 23:01:28 +0200
Message-Id: <1459371691-26216-1-git-send-email-lukasz.rymanowski@codecoup.pl>
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

Łukasz Rymanowski (3):
  shared/gatt-server: Add support for long write
  shared/gatt-db: Add API to get extended prop
  shared/gatt-server: Check for ext. charact. prop. on reliable session

 src/shared/gatt-db.c     |  62 +++++++++++++++++++++++
 src/shared/gatt-db.h     |   4 ++
 src/shared/gatt-server.c | 127 +++++++++++++++++++++++++++++++++++++++++------
 unit/test-gatt.c         |  14 ++++++
 4 files changed, 192 insertions(+), 15 deletions(-)

-- 
2.5.0


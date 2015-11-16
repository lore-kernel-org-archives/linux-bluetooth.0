Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH 0/4] shared/gatt: Couple fixes and improvements
Date: Mon, 16 Nov 2015 22:08:28 +0100
Message-Id: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've back to work on making Android gatt to make use of shared/gatt.
Here is couple of fixes I've done to shared code when doing this work.

Android gatt still needs testing but will be available sooner or later :) 

Łukasz Rymanowski (4):
  shared/gatt-server: Fix exit on error during execute write
  shared/gatt-client: Add notify type to notification callback
  shared/gatt-server: Improve long write session handling
  shared/gatt-server: Cancel remaining write exec on error in the middle

 profiles/scanparam/scan.c |   5 ++-
 src/gatt-client.c         |   4 +-
 src/shared/gatt-client.c  |  13 ++++--
 src/shared/gatt-client.h  |  13 ++++--
 src/shared/gatt-server.c  | 101 +++++++++++++++++++++++++++++++++++++++++++---
 tools/btgatt-client.c     |   2 +-
 unit/test-gatt.c          |  10 +++--
 7 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.5.0


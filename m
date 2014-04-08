Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 00/15] android/gatt: Gatt client improvements
Date: Tue, 8 Apr 2014 11:22:17 +0200
Message-ID: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds:
* caching primary and included sevices.
* fix in hanling included services
* add list of disconnected devices - thanks to this we keep 
cached services and next connect is faster.
* Fix  instance id for primary and included services

Lukasz Rymanowski (15):
  android/gatt: Change name of gatt_primary in service structure
  android/gatt: Add flag primary to struct service
  android/gatt: Add helper functions to send all primary services
  android/gatt: Use cached primary services if possible
  android/gatt: Add create_device helper function
  android/gatt: Add list of disconnected device
  android/gatt: Minor change in get_include_data
  android/gatt: Add msg size check for get included service
  android/gatt: Prepare to cache included services
  android/gatt: Add helper function to create_service
  android/gatt: Cache include services
  android/gatt: Add helper to send included service
  android/gatt: Change label name from failed to reply
  android/gatt: Use cache for included services
  android/gatt: Fix instance id for primary and included service

 android/gatt.c | 509 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 346 insertions(+), 163 deletions(-)

-- 
1.8.4


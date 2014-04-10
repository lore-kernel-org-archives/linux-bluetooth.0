Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/6] android/gatt: GATT client improvements
Date: Thu, 10 Apr 2014 10:42:55 +0200
Message-Id: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sets adds:
* preparation for client listen handling
* refactor send_client_connect_notify function
* fix scenario when application unregister client without proper cleaning

Lukasz Rymanowski (6):
  android/gatt: Add client listen support
  android/gatt: Refactor send_client_connect_notify
  android/gatt: Move functions up in the file
  android/gatt: Fix handling client unregister
  android/gatt: Move put_device_on_disc_list up in the file
  android/gatt: Move not used devices to disconnected dev queue

 android/gatt.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 282 insertions(+), 65 deletions(-)

-- 
1.8.4


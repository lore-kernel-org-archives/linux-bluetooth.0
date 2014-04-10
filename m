Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/5]android/gatt: GATT client improvements
Date: Thu, 10 Apr 2014 17:30:00 +0200
Message-Id: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sets adds:
* preparation for client listen handling
* refactor send_client_connect_notify function
* fix scenario when application unregister client without proper cleaning

v2:
* removed listen from this patch set. Will send it later.
* cleaning of other patches


Lukasz Rymanowski (5):
  android/gatt: Refactor send_client_connect_notify
  android/gatt: Fix handling client unregister
  android/gatt: Move functions up in the file
  android/gatt: Cleanup device lists
  android/gatt: Fix type of status parameter

 android/gatt.c | 209 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 146 insertions(+), 63 deletions(-)

-- 
1.8.4


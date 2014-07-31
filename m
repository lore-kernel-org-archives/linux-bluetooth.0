Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/6] android/gatt: Make usage of kernel auto connect feat.
Date: Thu, 31 Jul 2014 13:11:09 +0200
Message-Id: <1406805075-16150-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches add support to BfA to use kernel auto connect list
when mgmt interface is 1.7 or highier.

Tested on PC with latest kernel.

Lukasz Rymanowski (6):
  android/bluetooth: Add flag for kernel connection control
  android/bluetooth: Add API to add device to auto connect list
  android/bluetooth: Add API to remove device from auto connect list
  android/gatt: Refactor trigger connection function.
  android/gatt: Use kernel auto connect feature if possible
  android/bluetooth: Clear auto connect list on startup

 android/bluetooth.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h | 10 ++++++
 android/gatt.c      | 66 +++++++++++++++++++++++++++++--------
 android/main.c      |  4 +++
 4 files changed, 160 insertions(+), 14 deletions(-)

-- 
1.8.4


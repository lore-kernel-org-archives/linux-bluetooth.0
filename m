Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 0/6] [PATCH v2 0/6] android/gatt: Make usage of kernel auto connect feat.
Date: Fri,  1 Aug 2014 15:31:19 +0200
Message-Id: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches add support to BfA to use kernel auto connect list
when mgmt interface is 1.7 or highier.

Tested on PC with latest kernel.

v2: Fix in Patch 5/6. Forgot one if check
v3: Rebase + whitespace fix

Note: For android new backports are needed. Will be done early next week.

Lukasz Rymanowski (6):
  android/bluetooth: Add flag for kernel connection control
  android/bluetooth: Add API to add device to auto connect list
  android/bluetooth: Add API to remove device from auto connect list
  android/gatt: Refactor trigger connection function.
  android/gatt: Use kernel auto connect feature if possible
  android/bluetooth: Clear auto connect list on startup

 android/bluetooth.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h | 10 ++++++
 android/gatt.c      | 70 ++++++++++++++++++++++++++++++---------
 android/main.c      |  4 +++
 4 files changed, 163 insertions(+), 15 deletions(-)

-- 
1.8.4


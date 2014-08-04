Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 0/6] android/gatt: Make usage of kernel auto connect feat.
Date: Mon,  4 Aug 2014 12:34:13 +0200
Message-Id: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches add support to BfA to use kernel auto connect list
when mgmt interface is 1.7 or highier.

Tested on PC with latest kernel.

v2: Fix in Patch 5/6. Forgot one if check
v3: Rebase + whitespace fix
v4: Handle Johan comment

Note: For android new backports are needed. Will be done early next week.

Lukasz Rymanowski (6):
  android/bluetooth: Add flag for kernel connection control
  android/bluetooth: Add API to add device to auto connect list
  android/bluetooth: Add API to remove device from auto connect list
  android/gatt: Refactor trigger connection function.
  android/gatt: Use kernel auto connect feature if possible
  android/bluetooth: Clear auto connect list on startup

 android/bluetooth.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |   6 ++++
 android/gatt.c      |  70 ++++++++++++++++++++++++++++--------
 3 files changed, 162 insertions(+), 15 deletions(-)

-- 
1.8.4


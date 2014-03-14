Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/4] android:Add initial support for GATT Client
Date: Fri, 14 Mar 2014 14:49:35 +0100
Message-ID: <1394804979-7270-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set add GATT clien scan, connect/disconnect
functionality.

Some changes in handling discovery has been done as
there are two clients of discovery: HAL and GATT

For now daemon makes sure that device is available before
connecting it. It is because in case device is not available
we would block connect to other devices.

Once white list will be available we can simplify that code.

v2: Fixes in discovery handling

Jakub Tyszkowski (2):
  android/bluetooth: Add GATT notifications on LE discovery
  android/gatt: Use Core profile for LE scan

Lukasz Rymanowski (2):
  android/gatt: Add GATT Connect
  android/gatt: Add disconnect GATT device

 android/Android.mk  |   4 +
 android/Makefile.am |   3 +
 android/bluetooth.c | 105 ++++++++--
 android/bluetooth.h |   7 +
 android/gatt.c      | 589 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 691 insertions(+), 17 deletions(-)

-- 
1.8.4


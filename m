Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] android/gatt: Improve LE connection creation
Date: Thu, 19 Jun 2014 00:41:22 +0200
Message-Id: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With HOG implementation, LE connection has been changed in the way
that we use security level medium to connect bonded devices.

This patch set changes this and makes sure that HOG has enable encryption as
required by spec.
However for all other connection we always start from security LOW and increase security only when characteristic permissions requires this. 

This patch set is only compile-tested as I don't have HOG device here

Lukasz Rymanowski (4):
  android/gatt: Rename set_security function
  android/gatt: Add helper to set security level
  android/gatt: Expose function to set security on GATT
  android/hidhost: Start encryption for HOG when bonded

 android/gatt.c    | 61 ++++++++++++++++++++++++++++++++-----------------------
 android/gatt.h    |  2 ++
 android/hidhost.c |  4 ++++
 3 files changed, 42 insertions(+), 25 deletions(-)

-- 
1.8.4


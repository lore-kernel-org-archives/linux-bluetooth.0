Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 0/2] android: Enable debugs bluetoothd
Date: Wed, 5 Mar 2014 13:56:04 +0100
Message-ID: <1394024166-14102-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For user variant build of Android we should not print too much logs.
Therefore we should have possibility to turn on/off logs.

First patch adds simple on/off mechanism using android properties and
bluetoothd-wrapper.

Bluetoothd-wrapper is used because:
1. we can read android properties there
2. We can get early logs from daemon startup
3. bluetoothd-wrapper is not used in user variant build so debug logs
should be off on that variant by default.

Second patch gives us possibility to enable verbose logs and for now it
is mgmt interface logs which also might be useful in some cases.

For now, when verbose debugs are ON then also debug is ON.

Lukasz Rymanowski (2):
  android: Add possible to enable BlueZ debug logs
  android: Add verbose debugs to BlueZ

 android/README               | 16 ++++++++++++++++
 android/bluetooth.c          | 11 ++++++++++-
 android/bluetooth.h          |  2 +-
 android/bluetoothd-wrapper.c | 27 ++++++++++++++++++++++-----
 android/main.c               | 14 ++++++++++++--
 5 files changed, 61 insertions(+), 9 deletions(-)

-- 
1.8.4


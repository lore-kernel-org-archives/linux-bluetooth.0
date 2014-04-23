Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/3] android/bluetooth: Allow to start BlueZ in a single mode.
Date: Wed, 23 Apr 2014 18:53:24 +0200
Message-Id: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patches it is possible to start Bluez in a single mode.

v2: Refactor of previous patch so we don't disable already enabled LE mode.
It was actually not accodring to the spec.

Lukasz Rymanowski (3):
  android/bluetooth: Add supported lmp settings to adapter struct
  android/bluetooth: Do not enable BT LE by default
  android/bluetooth: Make possible to start BlueZ in a single mode

 android/README          |  4 ++++
 android/bluetooth.c     | 52 +++++++++++++++++++++++++++++++++++++++++--------
 android/bluetooth.h     |  2 +-
 android/hal-bluetooth.c | 19 +++++++++++++++++-
 android/hal-msg.h       |  2 ++
 android/main.c          |  5 ++++-
 6 files changed, 73 insertions(+), 11 deletions(-)

-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 0/3] Fixes for incoming connection and bonding
Date: Thu, 14 Nov 2013 16:24:17 +0100
Message-ID: <1384442660-2730-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V3:
Removed adapter bonding state
Added device list in order to track bonding state per device.
Fix for incoming legacy paring. We act here same as Bluedroid.

V2:
Bonding state added.

V1:
With those patches it is possible to bond from remote device and in addition
you will see the name of remote device on Android pairing request pop up.

Lukasz Rymanowski (3):
  android: Update bond state on incoming bonding
  android: Update bond state on auth and connect failed
  android: Change TODO with explaining comment

 android/bluetooth.c | 168 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 130 insertions(+), 38 deletions(-)

-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 0/4] Fixes for incoming connection and bonding
Date: Fri, 15 Nov 2013 19:03:57 +0100
Message-ID: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V5:
Fixes according to Johan comments

V4:
Added device name caching in device list
Changes according to Johan comments

V3:
Removed adapter bonding state
Added device list in order to track bonding state per device.
Fix for incoming legacy paring. We act here same as Bluedroid.

V2:
Bonding state added.

V1:
With those patches it is possible to bond from remote device and in addition
you will see the name of remote device on Android pairing request pop up.


Lukasz Rymanowski (4):
  android: Update bond state on incoming bonding
  android: Cache device name on device list.
  android: Update bond state on auth and connect failed
  android: Change TODO with explaining comment

 android/bluetooth.c | 212 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 173 insertions(+), 39 deletions(-)

-- 
1.8.4


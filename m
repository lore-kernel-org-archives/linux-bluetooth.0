Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/3] Fixes for incoming connection and bonding
Date: Tue, 12 Nov 2013 13:51:37 +0100
Message-ID: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
Bonding state added.

V1:
With those patches it is possible to bond from remote device and in addition
you will see the name of remote device on Android pairing request pop up.

Lukasz Rymanowski (3):
  android: Update bond state on incoming bonding
  android: Update HAL with device info on incoming connection
  android: Change TODO with explaining comment

 android/adapter.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 9 deletions(-)

-- 
1.8.4


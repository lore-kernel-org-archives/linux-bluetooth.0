Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] Fixes for incoming connection and bonding 
Date: Fri, 8 Nov 2013 16:48:28 +0100
Message-ID: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With those patches it is possible to bond from remote device and in addition 
you will see the name of remote device on Android pairing request pop up.

Lukasz Rymanowski (3):
  android: Update bond state on incoming bonding
  android: Update HAL with device info on incoming connection
  android: Change TODO with explaining comment

 android/adapter.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

-- 
1.8.4


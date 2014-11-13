Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] android/handsfree: Support multiply devices
Date: Thu, 13 Nov 2014 16:52:49 +0100
Message-Id: <1415893972-18656-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With those patches multilpy handsfree devices supports should be completed.

Compile tested.

Lukasz Rymanowski (3):
  android/handsfree: Send indicator notif to all connected devices
  android/handsfree: Send phone state to all connected devices
  android/handsfree: Remove find default device

 android/handsfree.c | 81 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

-- 
1.8.4


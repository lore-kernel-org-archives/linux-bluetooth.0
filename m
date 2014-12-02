Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] android/handsfree: Move to use bt_sco lib
Date: Tue,  2 Dec 2014 11:59:35 +0100
Message-Id: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set has couple of fixes plus patch moving sco handling to
bt_sco lib

Lukasz Rymanowski (4):
  android/handsfree: Fix handsfree idle state handling
  android/handsfree: Add default case to all the switches
  android/handsfree: Use bt_sco lib in HFP AG code
  android/handsfree: Simplify codec selection

 android/handsfree.c | 217 +++++++++++++++++++---------------------------------
 1 file changed, 77 insertions(+), 140 deletions(-)

-- 
1.8.4


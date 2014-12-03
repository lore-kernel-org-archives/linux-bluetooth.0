Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 0/3] android/handsfree: Move to use bt_sco lib
Date: Wed,  3 Dec 2014 11:42:23 +0100
Message-Id: <1417603346-6442-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set has couple of fixes plus patch moving sco handling to
bt_sco lib

v2:
* Improve disconnect_sco()
* remove patch adding default to switch/case
* Patch for handling idle state can be removed because of improvement of
disconnect_sco()

v3:
* added patch for disconnect SCO to bt_sco lib. this is needed for following patch

Lukasz Rymanowski (3):
  android/sco: Fix for disconnect SCO
  android/handsfree: Use bt_sco lib in HFP AG code
  android/handsfree: Simplify codec selection

 android/handsfree.c | 185 +++++++++++++---------------------------------------
 android/sco.c       |  12 +---
 2 files changed, 47 insertions(+), 150 deletions(-)

-- 
1.8.4


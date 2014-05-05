Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 0/2] LE testing on PTS
Date: Mon,  5 May 2014 11:17:31 +0200
Message-Id: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial patch for testing LE: GAP and GATT

Sebastian Chlad (2):
  android/pts: Run GATT PTS tests
  android/pts: Re-run GAP test suit

 android/pts-gap.txt  |   6 +--
 android/pts-gatt.txt | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 3 deletions(-)
 create mode 100644 android/pts-gatt.txt

-- 
1.8.5.3


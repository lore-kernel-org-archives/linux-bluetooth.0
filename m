Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] SPP PTS files
Date: Mon, 21 Jul 2014 16:39:40 +0200
Message-Id: <1405953581-9541-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update on SPP patch as there are 4 tests missing in PTS (checked against
Test Spec and TPG for SPP). Errata filled.

Sebastian Chlad (1):
  android/pts: Initial PTS docs for SPP

 android/Makefile.am   |  2 +-
 android/bite-spp.txt  | 19 ----------------
 android/pics-spp.txt  | 61 ++++++++++++++++++++++++++++++++++++++++-----------
 android/pixit-spp.txt | 19 ++++++++++++++++
 android/pts-spp.txt   | 26 ++++++++++++++++++++++
 5 files changed, 94 insertions(+), 33 deletions(-)
 delete mode 100644 android/bite-spp.txt
 create mode 100644 android/pixit-spp.txt
 create mode 100644 android/pts-spp.txt

-- 
1.8.5.3


Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] Interim test results for L2CAP
Date: Tue, 12 Aug 2014 15:38:05 +0200
Message-Id: <1407850686-26782-1-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
References: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tests run on a kernel with L.Rymanowski's patch:
"Bluetooth: Fix ERTM L2CAP resend packet"

Moreover instructions updated for CMC tests. Test run with -z option.

LE tests are passing. Test round was affected by the test environment.

Sebastian Chlad (1):
  android/pts: Update PTS files for L2CAP

 android/pics-l2cap.txt  | 11 +++++++----
 android/pixit-l2cap.txt |  2 +-
 android/pts-l2cap.txt   | 45 ++++++++++++++++++++++++---------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

-- 
1.8.5.3


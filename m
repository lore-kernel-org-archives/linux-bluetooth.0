Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] L2CAP tests on PTS 5.2
Date: Tue, 19 Aug 2014 10:32:33 +0200
Message-Id: <1408437154-7274-1-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
References: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the latest bluetooth-next all l2cap tests are passing except the one
on which there is an errata filled (bluetooth.org)

Sebastian Chlad (1):
  android/pts: Update PTS files for L2CAP

 android/pics-l2cap.txt  | 11 +++++++----
 android/pixit-l2cap.txt |  2 +-
 android/pts-l2cap.txt   | 46 ++++++++++++++++++++++++----------------------
 3 files changed, 32 insertions(+), 27 deletions(-)

-- 
1.8.5.3


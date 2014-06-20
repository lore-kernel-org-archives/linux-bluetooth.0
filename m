Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] DIS test files
Date: Fri, 20 Jun 2014 12:07:05 +0200
Message-Id: <1403258826-28190-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS for DIS in section 2: Service Requirements are mainly optional.
Section should be filled accordingly by developers so it will be clear
what is supported and what should be tested.

As of now most of the tests in pts-dis.txt are set to INC.

Sebastian Chlad (1):
  android/pts: Initial test files for DIS

 android/pics-dis.txt  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-dis.txt | 25 ++++++++++++++++++++++
 android/pts-dis.txt   | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 android/pics-dis.txt
 create mode 100644 android/pixit-dis.txt
 create mode 100644 android/pts-dis.txt

-- 
1.8.5.3


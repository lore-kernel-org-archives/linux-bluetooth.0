Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] Initial test files for ScPP
Date: Fri, 20 Jun 2014 13:25:31 +0200
Message-Id: <1403263532-3370-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some PICS for ScPP are optional. These PICS should be filled accordingly by
developers so it will be clear what is supported and what should be tested.

As of now most of the tests in pts-scpp.txt are set to INC.

Sebastian Chlad (1):
  android/pts: Initial test files for ScPP

 android/Makefile.am    |   5 +-
 android/pics-scpp.txt  | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-scpp.txt |  24 +++++++++
 android/pts-scpp.txt   |  25 +++++++++
 4 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-scpp.txt
 create mode 100644 android/pixit-scpp.txt
 create mode 100644 android/pts-scpp.txt

-- 
1.8.5.3


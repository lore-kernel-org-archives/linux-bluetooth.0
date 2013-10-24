Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] Enable av interface
Date: Thu, 24 Oct 2013 10:10:37 +0300
Message-Id: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For some reason get av interface was missing from hal-bluetooth and from
hal test tool.

PS: Not sure that haltest is fully implemented, Jerzy please comment here.

Andrei Emeltchenko (2):
  android: haltest: Enable av interface in test tool
  android: Enable AV interface

 android/client/if-bt.c  |    2 +-
 android/hal-bluetooth.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.7.10.4


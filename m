Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] User channel issue
Date: Tue,  5 May 2015 15:55:36 +0200
Message-Id: <1430834137-19064-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

While working with User Channel I've noticed that it is not possible to
bind to it from 'Index Added' callback. Returned error was EBUSY which
indicates that device is powered on (although mgmt settings show not powered).

The root cause is HCI_AUTO_OFF which keeps transport powered for seconds
after device is plugged.

I'm not quite sure how to fix this properly in kernel. Attached is an initial
version of tester that shows the bug (first test).

Userspace can workaournd the problem by toggling power on/off before
opening user channel (third test) or simply waiting >2 seconds before
opening it.

Comments are welcome.

Szymon Janc (1):
  tools: Add initial User Channel tester

 .gitignore                 |   1 +
 Makefile.tools             |  11 +-
 tools/userchannel-tester.c | 333 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tools/userchannel-tester.c

-- 
1.9.3


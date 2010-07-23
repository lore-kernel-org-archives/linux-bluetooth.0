Return-Path: <cyrus@holtmann.org>
From: Yuri Kululin <ext-yuri.kululin@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: ext-yuri.kululin@nokia.com
Subject: [PATCH 0/1] Bluetooth: RPN negotiation fix
Date: Fri, 23 Jul 2010 13:57:11 +0400
Message-Id: <1279879032-27955-1-git-send-email-ext-yuri.kululin@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RFCOMM port settings can be changed by using RPN command.
If the bit rate 115200 bit/s (which is not default according to
the ETSI 3GPP TS 07.10) is not supported by sender of RPN command
sender and receiver will never find an agreement. Currently RFCOMM accepts
115200 bit/s only.

This patch fixes this issue.

Please review.

Best regards,
Yuri Kululin

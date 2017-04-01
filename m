Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Possible crashing bug in bluez 5.44
References: <bbe1720b-5d67-2257-1be1-d1051790dbc4@cysioland.pl>
To: linux-bluetooth@vger.kernel.org
From: Cysioland <me@cysioland.pl>
Message-ID: <05483ac0-282d-5f1d-55ed-e2dadcb60dd1@cysioland.pl>
Date: Sat, 1 Apr 2017 11:15:19 +0200
MIME-Version: 1.0
In-Reply-To: <bbe1720b-5d67-2257-1be1-d1051790dbc4@cysioland.pl>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've encountered a possible bug when trying to connect my Bluetooth
headset via A2DP. Pairing is fine, but when it tries to connect the
bluetoothd segfaults, with the following stacktrace:

#0 0x0000000000469d60 n/a (bluetoothd)
#1 0x00000000004472d3 n/a (bluetoothd)
#2 0x000000000047a31d n/a (bluetoothd)
#3 0x0000000000447405 n/a (bluetoothd)
#4 0x00007f8ac61cf45a g_main_context_dispatch (libglib-2.0.so.0)
#5 0x00007f8ac61cf810 n/a (libglib-2.0.so.0)
#6 0x00007f8ac61cfb32 g_main_loop_run (libglib-2.0.so.0)
#7 0x000000000040b6b2 n/a (bluetoothd)
#8 0x00007f8ac57a5511 __libc_start_main (libc.so.6)
#9 0x000000000040bf0a n/a (bluetoothd)

I've installed bluez via Arch Linux packages, and after downgrading to
5.43 the bug no longer appears. I recall seeing lots of work done
between these two on A2DP, so I suspect a regression there.

Relevant Arch bug, where they told me to hit here:
https://bugs.archlinux.org/task/53442

Should I report it to your Bugzilla? Do you need any more info or help?

-- 
Yours Faithfully,
Cysioland
https://cysioland.pl

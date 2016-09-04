Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Date: Sun, 4 Sep 2016 19:10:17 +0200
Message-ID: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
Subject: btattach: auto triggering at boot time by Linux distributions
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

>From a Linux distribution point of view, what part of the stack is
expected (or would you recommend) to trigger the user-space btattach
command, to have Bluetooth enabled automatically at boot?

On an older computer, hot-plugging a Bluetooth USB adapter starts
Bluetooth automatically. On a ThinkPad 8 tablet, a manual btattach
command is currently needed to attach the hardware and load the
firmware for its Broadcom chip.

What do distro maintainers need to adapt to achieve the equivalent of
the USB auto-loading case for btattach-based chipsets, now that
btattach is starting to be included in some Linux distributions (such
as in Debian following this report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D816865 even if only
in experimental right now)?

Is it an already planned evolution on BlueZ side? Reading through the
mailing list, it doesn't seem to be the case but I may have missed a
discussion.

If not, any hints would be really appreciated, and especially your
view on which SW component would be a good candidate to take care of
this initialization task. Thanks a lot.

Regards,
J=C3=A9r=C3=B4me

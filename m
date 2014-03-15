Return-Path: <cyrus@holtmann.org>
Message-ID: <5324BBCF.1090101@hurleysoftware.com>
Date: Sat, 15 Mar 2014 16:45:03 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Sander Eikelenboom <linux@eikelenboom.it>
CC: "John W. Linville" <linville@tuxdriver.com>,
 "David S. Miller" <davem@davemloft.net>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RC6 Bell Chime] [PATCH 00/24] rfcomm fixes
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>	<3E0F3723-029F-4B12-8D77-9790FDBD3227@holtmann.org>	<1259174563.20140212120644@eikelenboom.it>	<1335661753.20140303203853@eikelenboom.it>	<1295963563.20140310093843@eikelenboom.it>	<20140310150858.GA25703@tuxdriver.com>	<EE67811F-FA2E-4773-8852-CB79BD7CDF1C@holtmann.org>	<1679354302.20140314014901@eikelenboom.it>	<53225B87.1030904@hurleysoftware.com>	<164289036.20140315145146@eikelenboom.it> <CA+55aFzLGvLhF258vCWbyvXX0UOJ_tcnKaNRz_38mR5rnO6e_Q@mail.gmail.com>
In-Reply-To: <CA+55aFzLGvLhF258vCWbyvXX0UOJ_tcnKaNRz_38mR5rnO6e_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/15/2014 01:53 PM, Linus Torvalds wrote:
> Guys, why is this being discussed?

FWIW, the 'known breakage' for 3.14 is a (valid) lockdep report.

This regression was introduced by a small patchset added to -next
over the holidays that was intended to address 2 bug reports
stemming from a long-overdue overhaul of the RFCOMM tty driver by
Gianluca Anzolin (which fixed numerous problems and several hangs
reported since 3.8).

It is the bulk of that small patchset which is being reverted.

The point of this brief history is that:
1) the 3.13 state of rfcomm is just as broken as 3.14-rcX, but
    in a different way
2) there are plenty of serious defects in both versions regardless.

I mean for this to be informative and not argumentative --
either outcome is ok with me. In fact, I'm ok if you want to
pick my entire 24-patch series that addresses the bugs in 3.13
and 3.14, plus a bunch of other problems that I found at the time.

Regards,
Peter Hurley

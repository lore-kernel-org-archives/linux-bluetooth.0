Return-Path: <cyrus@holtmann.org>
Message-ID: <527190DA.6000805@ahsoftware.de>
Date: Thu, 31 Oct 2013 00:06:02 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tim Tisdall <tim.tisdall@flemingcollege.ca>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: l2cap sockets not properly multiplexed on ARM
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local> <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
In-Reply-To: <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Am 30.10.2013 20:40, schrieb Marcel Holtmann:

...
>> So it's perfectly clear:  This all works fine on an x86 machine, but is an issue on ARM
...
> Do you have the chance to run bluetooth-next tree for testing purposes?

As Anderson Lizardo already mentioned, maybe first verify that the x86
kernel 3.4 doesn't have the same problem and that it's really a problem
of the ARM kernel. Up to now he didn't say what kernel version he uses
on x86.

Regards.

Alexander Holler

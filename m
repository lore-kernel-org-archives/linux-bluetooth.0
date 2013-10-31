Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: l2cap sockets not properly multiplexed on ARM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
Date: Thu, 31 Oct 2013 15:20:18 +0100
Cc: Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local> <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>,<527114A4.5010207@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local> <4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>,<527190DA.6000805@ahsoftware.de> <D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
To: Tim Tisdall <tim.tisdall@flemingcollege.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

>> As Anderson Lizardo already mentioned, maybe first verify that the x86
>> kernel 3.4 doesn't have the same problem and that it's really a problem
>> of the ARM kernel. Up to now he didn't say what kernel version he uses
>> on x86.
> 
> here's my desktop version:
> $ uname -a
> Linux tzing 3.8.0-32-generic #47-Ubuntu SMP Tue Oct 1 22:35:23 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
> 
> I'm trying to get an older version of the kernel running on another machine and then I'll report back

I actually need to know if bluetooth-next tree still has this issue. That is first and foremost the one thing that needs to be checked.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
	<5270EC62.6070705@ahsoftware.de>
	<5270F19A.4030408@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>
	<527114A4.5010207@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE2032419A8@AD-BR-EX-2.adroot.flemingc.local>
	<4A213FF7-48BA-4906-8868-7C3A227EF954@holtmann.org>
	<527190DA.6000805@ahsoftware.de>
	<D9B9EB3A112B8F489DFFA00A6D5C0FE203241BE2@AD-BR-EX-2.adroot.flemingc.local>
	<F9B30CD6-4DCB-4F58-9322-E18969867664@holtmann.org>
Date: Fri, 1 Nov 2013 07:03:27 -0400
Message-ID: <CAJdJm_O1-=-cEKnuSmT026hr1JOkwiRZfC3Q_qagTWOna5JN7w@mail.gmail.com>
Subject: Re: l2cap sockets not properly multiplexed on ARM
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tim Tisdall <tim.tisdall@flemingcollege.ca>, Alexander Holler <holler@ahsoftware.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 31, 2013 at 10:20 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tim,
>
>>> As Anderson Lizardo already mentioned, maybe first verify that the x86
>>> kernel 3.4 doesn't have the same problem and that it's really a problem
>>> of the ARM kernel. Up to now he didn't say what kernel version he uses
>>> on x86.
>>
>> here's my desktop version:
>> $ uname -a
>> Linux tzing 3.8.0-32-generic #47-Ubuntu SMP Tue Oct 1 22:35:23 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>
>> I'm trying to get an older version of the kernel running on another machine and then I'll report back
>
> I actually need to know if bluetooth-next tree still has this issue. That is first and foremost the one thing that needs to be checked.

I asked Tim to mention the kernel version on x86 vs. the version on
ARM, because I vaguely remember this same issue being reported last
year (or even 2011) and being fixed (If I find the patch, I will let
you know). As Tim mentions later on, on x86 the issue does not happen
on 3.8, but it is present on 3.2 (and I suspect it will also be
present on 3.4 on x86 as well).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

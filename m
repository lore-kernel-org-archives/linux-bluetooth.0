Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090516225406.GA19041@jh-x301>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
	 <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
	 <20090515182256.GA18375@jh-x301> <20090516225406.GA19041@jh-x301>
Date: Sun, 17 May 2009 12:57:25 +0530
Message-ID: <8b5debfa0905170027t45955215p2b9edb663a27c4e2@mail.gmail.com>
Subject: Re: [PATCH 2/7] Adding set_powered method to hciops plugin.
From: alok barsode <alokbarsode@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: marcel@holtmann.org
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, May 17, 2009 at 4:24 AM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
> Hi Alok,
>
> On Fri, May 15, 2009, Johan Hedberg wrote:
>> I'm going through your patches now and I found at least one issue:
>>
>> > + =A0 hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
1, SCAN_DISABLED);
>>
>> This looks wrong. The last parameter should a pointer and not an integer=
.
>
hmmm right, I show assign 'SCAN_DISABLE' to a variable and send its
address to hci_send_cmd.

> There's another issue with this patch as well:
> adapter.c: In function =91set_mode=92:
> adapter.c:403: error: =91dd=92 may be used uninitialized in this function
>
> I'd have fixed both issues for you (since they are rather trivial) but
> then your third patch doesn't apply cleanly anymore. So please fix these
> issues, check that no patch causes any compilation warning or error, and
> resend them. Thanks.
>
The 3rd patch has dependencies on the 1st patch (using hci_send_cmd
for hci_send_req) .
did u get time to test that patch?

Thanks for fixing patch2.

do you want me to rework all the patches so as to remove dependency on patc=
h1?
(which would basically mean removing that patch).

Cheers,
Alok

> Johan
>

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140125231309.GB16167@x220.p-661hnu-f1>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
	<20140125221203.GA14531@x220.p-661hnu-f1>
	<CAJdJm_PPeA-DHfFPKi=iwjb_Kc4rrU8zY6SgX-G_O9ts3wCaZw@mail.gmail.com>
	<20140125231309.GB16167@x220.p-661hnu-f1>
Date: Sat, 25 Jan 2014 19:16:18 -0400
Message-ID: <CAJdJm_OHXqKNy71L+9Z6s5jKseh1oz_F_w8x3cS2DTjJwF_9iA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sat, Jan 25, 2014 at 7:13 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> What about the suggestion to make l2cap-tester check if LE CoC is
>> enabled on the kernel and skip the the tests that depend on it? Right
>> now, the tests simply fail which is misleading (at first I thought it
>> was a regression).
>>
>> Another option is to change the test name to mention that they require
>> enabling LE CoC.
>
> This has never bothered me much since the assumption is that mainly
> developers would be running these tools and therefore know the
> implications and requirements. I have a feeling that adding this kind of
> checks might be a bit overkill, especially since this debugfs entry will
> disappear as soon as we do one more test run at the UPF next week. After
> that LE CoC support will always be there if you've got a new enough
> kernel.

If the are plans to have this option removed real soon, no problem for me then.

Best Regards,
-- 
Anderson Lizardo
INdT - Manaus - Brazil

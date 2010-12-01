Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101201212034.GE16125@vigoh>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1291215506-11398-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20101201212034.GE16125@vigoh>
Date: Wed, 1 Dec 2010 17:31:15 -0400
Message-ID: <AANLkTi==oXHyrtkjRD_mbmRFsDnTH7+S_JOFHRemXJLG@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] Bluetooth: clean up sco code
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 1, 2010 at 5:20 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> -static int disable_esco = 0;
>> +static int disable_esco;
>
> I don't think this change is right. Can we be sure that disable_esco
> will be 0 by default?

I think Andrei's patch is ok. IIRC kernel zeroes BSS on init, that's
why checkpatch.pl complains when you initialize it explicitely.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

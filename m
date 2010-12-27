Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101227214841.GA22777@jh-x301>
References: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
	<1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
	<20101227214841.GA22777@jh-x301>
Date: Mon, 27 Dec 2010 18:24:26 -0400
Message-ID: <AANLkTi=dsEwvjAOGM7eFdDDZSXUrPuA5wjQw8VcWH8N5@mail.gmail.com>
Subject: Re: [PATCH v2] Fix leak of EIR data if RSSI does not change
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Dec 27, 2010 at 5:48 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Beware of words like "also" and "and" in commit messages. Often they are
> a good indication that the patch shold be split into multiple ones.
> Though in this case I can't really make up my mind if it's fine since
> the changes are so strongly related. I'll leave it up to you to think
> about it and decide if you can cleanly split this into two patches or
> not.

I can split into two patches without problem.

> It looks to me like shortened names are completely ignored after this
> patch, even to the extent that if there's a shortened name the memory
> will be leaked if adapter_update_found_devices returns TRUE.
>
> If we don't have any name in storage and all we have is a shortened name
> then I think it should be included in the DeviceFound signal (which is
> what the existing code does).

You are right. Somehow I forgot about the shortened name case while
trying to refactor this part of the code.

I'll resend the patch with just the memory leak fix (taking care to
not introduce another one!) and if I still have any idea to simplify
this code (which I don't believe anymore) a second patch will come.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

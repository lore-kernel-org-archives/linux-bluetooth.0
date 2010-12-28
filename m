Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=dsEwvjAOGM7eFdDDZSXUrPuA5wjQw8VcWH8N5@mail.gmail.com>
References: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
	<1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
	<20101227214841.GA22777@jh-x301>
	<AANLkTi=dsEwvjAOGM7eFdDDZSXUrPuA5wjQw8VcWH8N5@mail.gmail.com>
Date: Tue, 28 Dec 2010 14:16:47 -0400
Message-ID: <AANLkTikPRjKGc3qX-t7kwJgXPdMjCmTqBSi0Tjfc8bW-@mail.gmail.com>
Subject: Re: [PATCH v2] Fix leak of EIR data if RSSI does not change
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Dec 27, 2010 at 6:24 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Mon, Dec 27, 2010 at 5:48 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Beware of words like "also" and "and" in commit messages. Often they are
>> a good indication that the patch shold be split into multiple ones.
>> Though in this case I can't really make up my mind if it's fine since
>> the changes are so strongly related. I'll leave it up to you to think
>> about it and decide if you can cleanly split this into two patches or
>> not.
>
> I can split into two patches without problem.

I just sent a v3 of this patch, which I hope fix all issues. It is
bigger than previous versions, but I assure it is solely to fix the
leak of EIR data. The other benefits are just "side effects":

* That if() clause which handles EIR name has been simplified, by
removing free()/g_free()
* I avoid passing ownership of memory allocated in src/event.c to
src/adapter.c, which would potentially become memory leaks if not
managed carefully.

I hope these side effects are not of a big issue to be kept in a single patch.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

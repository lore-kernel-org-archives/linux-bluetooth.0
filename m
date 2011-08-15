Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+DY-ZKxcOXi7F46miGKTP=QkMiaUUXRmgZtuVx-TXdsg@mail.gmail.com>
References: <1311689387-10114-1-git-send-email-prasadbhat22@gmail.com>
	<4E2ECCF0.6050106@kernelconcepts.de>
	<20110726143637.GA3587@dell.ger.corp.intel.com>
	<CA+y7xkER2Y+jJum=JBwzNcY0Pg_drvnjG_E12jDQ6kKZYbkQVw@mail.gmail.com>
	<CABBYNZ+DY-ZKxcOXi7F46miGKTP=QkMiaUUXRmgZtuVx-TXdsg@mail.gmail.com>
Date: Mon, 15 Aug 2011 15:09:13 +0300
Message-ID: <CABBYNZKTDLGjtSZTZQ5YhTJnqPdQQw7-6UsuNe-r3rvx_eVLLA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] Initial VDP implementation.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: Nils Faerber <nils.faerber@kernelconcepts.de>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 27, 2011 at 2:10 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Jul 26, 2011 at 6:23 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
>> Hi,
>>
>> On Tue, Jul 26, 2011 at 8:06 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
>>> Couple of other notes:
>>>
>>> - The patch is huge. Any chance of splitting it up into smaller chunks?
>>> - Since there's so much in common with a2dp.c it'd make sense to attempt
>>>  some refactoring.
>>> - Now that audio/*.c does video too we might consider renaming the
>>>  audio plugin and directory to something else.
>
> Maybe we can have e.g. sep.c which implements generic sep handling
> which can be reused by both vdp and a2dp, how about that?

Is this coming anytime soon?


-- 
Luiz Augusto von Dentz

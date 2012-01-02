Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJvJKWHpecJyYw2bbEGyM_jqBLysX4pmmfdNRwdxi05vA@mail.gmail.com>
References: <CAMp=V3rgF2GdEqcTpkpB6QGc03JHmawh7GM0h=rvqyHcQHdg7g@mail.gmail.com>
	<CABBYNZJvJKWHpecJyYw2bbEGyM_jqBLysX4pmmfdNRwdxi05vA@mail.gmail.com>
Date: Mon, 2 Jan 2012 18:22:55 +0000
Message-ID: <CAMp=V3oZNL_HucJ7RNBqJFXu9tVKX-=K6C6xwk5eb-Wi233rhg@mail.gmail.com>
Subject: Re: Bluetooth audio skipping
From: Michael Maddern <michael.maddern@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On 2 January 2012 13:06, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Michael,
>
> On Fri, Dec 30, 2011 at 3:26 PM, Michael Maddern
> <michael.maddern@gmail.com> wrote:
>> Hello,
>>
>> I'm not sure I'm supposed to be posting here, but on bluez.org both
>> the development and user mailings lists point here.
>>
>> I'm having problems getting bluetooth audio (a2dp) to work without
>> stuttering, skipping, speeding up etc. I'm using bluetooth speakers
>> (Creative D100). It works okay if it is right next to my laptop, but
>> when I touch the speaker or move it more than about 1 meter, it starts
>> stuttering.
>
> I have the D100 and haven't noticed such a problem.
>
>> The bluetooth adapter is a Broadcom BCM2070 (which is a class 1
>> adapter). I'm using kernel 3.1.5-1.
>>
>> I've tested it with the Bluez 4.96, and I've also compiled 4.97 but
>> it's no better. I've tried using Alsa and PulseAudio, the problem is
>> the same with both.  I've tried adjusting the link mode
>> (accept,master) and link policies (hold,park) as recommended but it
>> makes no difference.
>
> What version of PulseAudio are you using? This problems with audio
> skips are usually related to high bitpool, but there already exist a
> fix upstream which reduces the bitpool in such cases.
>
>> When I dual boot my laptop into Windows 7 and connect the speaker it
>> works flawlessly. I'm able to take the speaker through 2 rooms (about
>> 10 minutes), and it's still playing smoothly.
>
> Not sure what bitpool Win 7 uses, but I suspect it is not as high as
> the default in PA which allows up to 64 if the remote device supports.
>
> --
> Luiz Augusto von Dentz


Thanks for the reply. Good to know you have the same speaker working well.

I'm using Pulse Audio version 1.1.

In the bluetooth log when the speaker is connected it reports
"Bitpool: 2-53". I compiled the patch suggested here:

https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/424215/comments/34

I guess this would reduce the maximum bitpool by 20 but it didn't
appear to make much difference.


Regards,
Michael

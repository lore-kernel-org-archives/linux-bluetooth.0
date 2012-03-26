Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLnC5a0zBv3V2dCJ-M9Tq=XtVXVBt12zRGFFbN0FOTWEQ@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
	<CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
	<CABBYNZK5yFoR9nGjU8=U4g+VkLc281Hh9QhYT5m9hTxoZLFoaw@mail.gmail.com>
	<CAB7rCTiJZqPCYGZo+rJ+dnxmR6y6hnksRrzqnbyPv8i72=qq8g@mail.gmail.com>
	<CABBYNZJNFCBdOzLHX2LMTeULkyhCEHsGv+_41wUsvTrhCL48YQ@mail.gmail.com>
	<CAB7rCTgJrxKZurWVq7ixt7NGJ6D6d-urtYe3UDKR+9bxQdgdEQ@mail.gmail.com>
	<CABBYNZLnC5a0zBv3V2dCJ-M9Tq=XtVXVBt12zRGFFbN0FOTWEQ@mail.gmail.com>
Date: Mon, 26 Mar 2012 11:49:44 -0500
Message-ID: <CAB7rCTjHnr2jgqzj3Kv6wsPUSNTaphanrfR=nC8ioD=NHMtU2w@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 26, 2012 at 11:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mike,
>
> On Mon, Mar 26, 2012 at 12:44 PM, Mike <puffy.taco@gmail.com> wrote:
>> True, but I'm testing all the possible user experiences and that's not
>> an acceptable solution.  The particular case I'm testing is that the
>> user deleted the pairing on one end but not the other.  I can't
>> control what the software on my phone does; I'm only reporting how it
>> interacts with BlueZ running on my device.  It's true that the next
>> time the connection occurs (provided we eventually figure out a SEP
>> lock fix), everything will work just fine.  I'm just trying to figure
>> out what goes wrong the first time.  So any pointers you have would be
>> great.
>
> So you are deleting the link key on your phone and still initiating
> the connection from it, that doesn't sound like a practical case since
> by removing the key the phone should no longer remember your device.
> Anyway, that seems that something else is broke because the connection
> should be authenticated before accepted by userspace, in other words
> the signalling channel connection should not be established before the
> pairing completes.

I'm probably not being clear on the specifics (they are clear in my
head!).  My phone is an old Motorola KRZR K1.  I do not delete the
link key here -- it assumes we're still paired and is attempting to
open the A2DP.  The device it is connecting to uses BlueZ in an HFP HF
role.  It is on this device (BlueZ) that I have deleted the link key.
So, the phone does remember the past pairing and is attempting at
connect as if the two are still paired -- making this a practical
case.  So I agree that something is broken here as to why the process
continues while pairing is occurring.

>>>> What exactly is this timeout waiting for?  I haven't figured that out
>>>> yet.  I assume it's waiting on something from my phone (the a2dp
>>>> source) and not D-Bus?
>>>
>>> The client is would be waiting the reply of Acquire, so if you setup
>>> something over D-Bus timeout there is a chance the device respond
>>> correctly but the client will ignored because the method call already
>>> timed out.
>>
>> Well, this case helps out in a time where I didn't call Acquire (the
>> phone initiated the connection).  So it seems like there should be a
>> check for pairing before initiating the timer.  I'm not sure how that
>> would work or what would be needed to make that foolproof.  For my
>> situation, a much higher timeout was sufficient (I'm not saying that
>> it should be set to 60 in bluez.git -- just that for me it works).

The timeout of 2 seconds is just fine when the two devices are paired.
 I only run into this issue of crashing my phone when the BlueZ device
deletes the pairing.  I'm sure it's my phone's fault for crashing, but
fixing the upper issue will fix this as well.

Mike

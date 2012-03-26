Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJNFCBdOzLHX2LMTeULkyhCEHsGv+_41wUsvTrhCL48YQ@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
	<CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
	<CABBYNZK5yFoR9nGjU8=U4g+VkLc281Hh9QhYT5m9hTxoZLFoaw@mail.gmail.com>
	<CAB7rCTiJZqPCYGZo+rJ+dnxmR6y6hnksRrzqnbyPv8i72=qq8g@mail.gmail.com>
	<CABBYNZJNFCBdOzLHX2LMTeULkyhCEHsGv+_41wUsvTrhCL48YQ@mail.gmail.com>
Date: Mon, 26 Mar 2012 10:44:39 -0500
Message-ID: <CAB7rCTgJrxKZurWVq7ixt7NGJ6D6d-urtYe3UDKR+9bxQdgdEQ@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 26, 2012 at 10:01 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mike,
>
> On Fri, Mar 23, 2012 at 12:30 PM, Mike <puffy.taco@gmail.com> wrote:
>> It does appear to trigger based on the signalling channel, however it
>> appears that the connection process continues on regardless.  I pasted
>> below a log, everything in the log occurs while my phone is still
>> asking me if I want to pair with the BlueZ device.  We don't get
>> beyond the OPEN_CMD into an actual OPEN state until the pairing
>> process completes.
>
> Why don't you pair it before hand, actually this should happen only
> once in the first time you pair and then it should be stored
> persistently so the next time you wont see this problem.

True, but I'm testing all the possible user experiences and that's not
an acceptable solution.  The particular case I'm testing is that the
user deleted the pairing on one end but not the other.  I can't
control what the software on my phone does; I'm only reporting how it
interacts with BlueZ running on my device.  It's true that the next
time the connection occurs (provided we eventually figure out a SEP
lock fix), everything will work just fine.  I'm just trying to figure
out what goes wrong the first time.  So any pointers you have would be
great.

>>> 60 seconds is way too long, it should be at least smaller than D-Bus
>>> default timeout which is 25 sec.
>>
>> What exactly is this timeout waiting for?  I haven't figured that out
>> yet.  I assume it's waiting on something from my phone (the a2dp
>> source) and not D-Bus?
>
> The client is would be waiting the reply of Acquire, so if you setup
> something over D-Bus timeout there is a chance the device respond
> correctly but the client will ignored because the method call already
> timed out.

Well, this case helps out in a time where I didn't call Acquire (the
phone initiated the connection).  So it seems like there should be a
check for pairing before initiating the timer.  I'm not sure how that
would work or what would be needed to make that foolproof.  For my
situation, a much higher timeout was sufficient (I'm not saying that
it should be set to 60 in bluez.git -- just that for me it works).

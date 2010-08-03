Return-Path: <cyrus@holtmann.org>
Message-ID: <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
In-Reply-To: 
     <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.athero
     s.com>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
    <1280775200.12579.30.camel@localhost.localdomain>
    <B7132A25476D334D9130FE7532F2A56310A0B0896E@SC1EXMB-MBCL.global.atheros.com>
    <1280789882.12579.66.camel@localhost.localdomain>
    <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
Date: Mon, 2 Aug 2010 18:30:34 -0700 (PDT)
Subject: RE: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "Kevin Hayes" <kevin@Atheros.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
 "tmonahan@codeaurora.org" <tmonahan@codeaurora.org>,
 "David Vrabel" <david.vrabel@csr.com>,
 "Inga Stotland" <ingas@codeaurora.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "rshaffer@codeaurora.org" <rshaffer@codeaurora.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel and Kevin,

>> >
>> > Agree that it should be done "in background" and that a size
>> threshold would be useful.  But who evaluates that threshold?  The
>> bluez kernel components, which essentially implement a transport
>> driver, should not be examining objects (files, phonebooks, etc) size
>> to see if this threshold is met.  Therefore, it would seem Tim's
>> suggestion of having the profile send a 'prefer_amp' bit would be
>> useful, right?
>>
>> I would do something like "prefer_amp when over 100kb" or something.
>> And
>> then the kernel needs to count. Meaning the L2CAP layer could easily
>> count this by itself.
>
> What?  Let's say the effect we want is that if the object is greater than,
> say, 10 megabytes, then we want to use AMP for the transfer.  With your
> scheme, you want the kernel to count up to 10 megabytes, THEN switch over
> to AMP?
> No, you don't, he says rhetorically.  :)

If the policy was defined as "prefer_amp after n seconds" we would get the
desired effect without having to do any counting in the kernel.

>>
>> Also just starting with setsockopt(bredr_only) and then later on just
>> doing setsockopt(prefer_amp) the userspace application would have
>> control over switching manually.
>
> How is this really different from your ioctl(switch_now_to_amp) below,
> which looks very wrong?
>
>>
>> Since the polices are on a per socket basis, I don't see a big problem
>> with doing it like this.
>>
>> The only thing that I don't want is a ioctl(switch_now_to_amp) since
>> that looks very wrong to me.
> Agreed.
>
>>
>> > > The other problem here is also that besides whatever the profiles
>> > > wants,
>> > > it might happen that the WiFi policy is stronger and only allows
>> using
>> > > the WiFi device as WiFi or as AMP. And if WiFi wins, then we have
>> to
>> > > rip
>> > > the AMP out of the system. At that point whatever the Bluetooth
>> > > profiles
>> > > wanted is pointless since the AMP controller is gone anyway.
>> >
>> > Well, I think this is best managed by having the PAL announce its
>> availability (and unavailability) to A2MP, using the spec's HCI events
>> for this purpose.  A2MP can then be the agent to move the channel to
>> AMP or not, accordingly.  For example, it might be that the 802.11
>> device is being used for an infrastructure link, and then that link
>> goes away.  The PAL would then announce its availability to the BT
>> stack (A2MP), and A2MP would then move the channel to AMP.
>>
>> Agreed. My point was just that application can only set a policy. They
>> can't switch manually. If application would switch manually then they
>> need to check PAL availability etc. I don't want that complexity inside
>> the applications.
>>
>> > > That said, nothing stops us from allowing to make our AMP polices
>> > > dynamic and allow the application to change it threshold during
>> > > lifetime. For example it starts out as BR/EDR only and then during
>> the
>> > > usage of the link it decides that now AMP preferred would make
>> sense.
>> > > In
>> > > that sense you would have manual switching to some level.
>> >
>> > The only use case I see for manual switching is debugging.
>>
>> That is fine. We can do that via debugfs.
>>
>> Regards
>>
>> Marcel
>>
>
> èº{.nÇ+‰·Ÿ®‰­†+%ŠËlzwm…ébë§²æìr¸›zX§»å¹ëh¢ØbØ^n‡r¡ö¦zËëh™¨è­Ú&¢ø®G«éh®(­éšŠİ¢j"ú¶m§ÿïêäz¹Ş–Šàşf£¢·hšˆ§~ˆmš

Regards,

Peter.

-- 

Peter Krystad

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

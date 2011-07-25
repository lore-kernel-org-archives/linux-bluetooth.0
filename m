Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311601088.8920.4.camel@aeonflux>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
	<1309309092.2208.25.camel@aeonflux>
	<CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
	<1311601088.8920.4.camel@aeonflux>
Date: Mon, 25 Jul 2011 17:48:34 +0300
Message-ID: <CAHMBquX9Vo=Rr4Uzr-8mN2tOB7bV4a5ypVidMxpnTMQLJ1vX1Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Antti Julku <antti.julku@nokia.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 25, 2011 at 4:38 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Dmitriy,
>
>> >> +#define MGMT_OP_SET_FAST_CONNECTABLE 0x001F
>> >> +struct mgmt_cp_set_fast_connectable {
>> >> + =A0 =A0 __u8 enable;
>> >> +} __packed;
>> >> +
>> >
>> > so I am not 100% sure that doing it this way is the best way.
>> >
>> > What is the down side of just enabling interlaced page scan all the
>> > time? And then maybe allow tuning of the timeout via debugfs for testi=
ng
>> > purposes.
>>
>> This mode changes two parameters: page scan type and page scan
>> interval. There two downsides to have those changed all the time:
>> 1) power consumption
>> 2) re-transmissions on eSCO channel (see BT Core v4.0, Vol. 2, p. 159)
>>
>> In this configuration page scanning happening during all dedicated
>> slots and much more frequently. This is why probably it is not very
>> good idea to have it enabled all the time, but only during short time
>> interval when there are benefits out of such changes.
>
> so the expectation is that bluetoothd or some sort of its plugin keep
> changing from connectable to fast connectable multiple multiple times
> during the lifecycle and based on some specific policy.

That's correct.

> Can you give us some more background on how and when you change the
> modes here. Some simple flow-chart or so.

Fast connectable is switched on when incoming/outgoing call alerting
starts and respectively switched off when alerting stops (i.e. call is
answered/rejected/dropped) as it is implemented in telephony-maemo6
pluging.

The use case is that it enables shorter connection time when user
answers incoming call using headset when the headset is switched off
or disconnected.

>
>> > If we really wanna differentiate between connectable and fast
>> > connectable, then we need to fix up also the controller information to
>> > export this kind of detail. That will get pretty messy right now. So I
>> > would really just prefer to go with interlaced page scan by default an=
d
>> > see what downside this gives us.
>>
>> This is the way how fast connectable implementation is done currently
>> for hci_ops. It is disabled by default and default values for page
>> scan type and page scan interval are used. If one wishes to enable it,
>> audio.conf is used for that purpose. In that case, fast connectable
>> configuration is enabled during incoming/outgoing call alerting only.
>> In this case, connection initiated from headset side can be performed
>> much faster during that specific time interval.
>>
>> Hope this clarifies the questions. What do you think? Could you
>> elaborate more on 'then we need to fix up also the controller
>> information to export this kind of detail.'? Why that is needed?
>
> I like to figure out on what is the best interface to the kernel. Is
> this something really specific or should it be more generic. So for
> example program the page scan intervals into the kernel first. And then
> just toggle. Or have the interval as part of the command to toggle.
>
> And main concern is if multiple profiles wanna make us of it. How do we
> handle that part.

It seems like Claudio's input is quite crucial on how to align it with
LE. Looks like it is quite generic.

BR,
Dmitriy

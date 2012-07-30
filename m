Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343399863.1803.10.camel@aeonflux>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	<1343138034.24426.55.camel@aeonflux>
	<CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
	<1343399863.1803.10.camel@aeonflux>
Date: Mon, 30 Jul 2012 12:00:50 +0530
Message-ID: <CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Manoj Sharma <ursmanoj@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/27/12, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manoj,
>
>> >> These patches allows L2CAP socket user to reserve bandwidth in
>> >> percentage. Underlying socket reserves calculated number of
>> >> HCI credits for this L2CAP channel.
>> >
>> > this description is by far not enough. Explain why you are doing this.
>> > And make it a detailed description. Preferable with hcidump traces
>> > showing why this makes a difference at all.
>> >
>> This patch simply adds an additional L2CAP socket option for reserving
>> bandwidth.
>> The reserved bandwidth would result into reserving calculated number
>> of ACL data credits. Thus the L2CAP channels without this option set
>> would not be able to use all available ACL buffers in controller. This
>> would ensure that whenever an L2CAP channel with this option set has
>> data to send, it does not starve or wait because of other channels
>> already using all controller buffers.
>>
>> Above explanation is most suitable in case when simultaneous AVDTP
>> streaming channels and other channels (e.g. OPP, PBAP etc) are in
>> action. Such an arrangement for reserving credits would allow AVDTP
>> stream to flow to controller without any obstacle from simultaneous
>> traffic and help removing glitches in music streaming over Bluetooth.
>> Please suggest if this description is sufficient and if I should push
>> patch-set again.
>
> and what is the problem with using SO_PRIORITY for this?
>
One problem which I have faced using SO_PRIORITY is explained below.

Suppose we have 2 links A & B and link A has higher priority than link
B. And outgoing data transfer is active on both links. Now if device
on link A goes far, there would be lot of failures and number of
re-transmissions would increase for link A. Consequently at any time
host would have significant number of packets for link A, getting
accumulated due to poor quality of link.But since link A packets have
higher priority, link B packets would suffer infinitely as long as
link A packet queue in host is non-empty. Thus link B protocols may
fail due to timers expiring and finally disconnection at upper layers.

Second problem:
We have two links similar to above scenario. Say link A is being used
by AVDTP and link B is being used by OBEX. Host can come across a
situation where all controller buffers are used by OBEX and AVDTP is
waiting for a free buffer. Now due to some reason (e.g. distance) OBEX
link B goes weak. This results into delay in transmission of OBEX
packets already held by controller and consequently AVDTP packets also
get delayed which causes glitches in music streaming and user
experience goes bad.

These are the basic problems which I have faced and hence felt
necessity of a similar but different mechanism and came up with this
solution. This solution fixes both of the problems explained above.
Based on the explanation above your suggestion is required further.

> Regards
>
> Marcel
>
>
>
Best regards,
Manoj

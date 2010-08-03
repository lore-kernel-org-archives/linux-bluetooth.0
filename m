Return-Path: <cyrus@holtmann.org>
Message-ID: <b93d3fcab246c34ed104129b0850495d.squirrel@www.codeaurora.org>
In-Reply-To: <20100803080719.GD20149@vigoh>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
    <1280775200.12579.30.camel@localhost.localdomain>
    <B7132A25476D334D9130FE7532F2A56310A0B0896E@SC1EXMB-MBCL.global.atheros.com>
    <1280789882.12579.66.camel@localhost.localdomain>
    <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
    <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
    <20100803080719.GD20149@vigoh>
Date: Tue, 3 Aug 2010 08:40:57 -0500 (CDT)
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: "Tim Monahan-Mitchell" <tmonahan@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: "Peter Krystad" <pkrystad@codeaurora.org>,
 "Kevin Hayes" <kevin@atheros.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "tmonahan@codeaurora.org" <tmonahan@codeaurora.org>,
 "David Vrabel" <david.vrabel@csr.com>,
 "Inga Stotland" <ingas@codeaurora.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "rshaffer@codeaurora.org" <rshaffer@codeaurora.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Reply-To: tmonahan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Gustavo and Marcel,

> Hi Peter,
>
> * Peter Krystad <pkrystad@codeaurora.org> [2010-08-02 18:30:34 -0700]:
>
>>
>> Hi Marcel and Kevin,
>>
>> >> >
>> >> > Agree that it should be done "in background" and that a size
>> >> threshold would be useful.  But who evaluates that threshold?  The
>> >> bluez kernel components, which essentially implement a transport
>> >> driver, should not be examining objects (files, phonebooks, etc) size
>> >> to see if this threshold is met.  Therefore, it would seem Tim's
>> >> suggestion of having the profile send a 'prefer_amp' bit would be
>> >> useful, right?
>> >>
>> >> I would do something like "prefer_amp when over 100kb" or something.
>> >> And
>> >> then the kernel needs to count. Meaning the L2CAP layer could easily
>> >> count this by itself.
>> >
>> > What?  Let's say the effect we want is that if the object is greater
>> > than, say, 10 megabytes, then we want to use AMP for the transfer.
>> > With your scheme, you want the kernel to count up to 10 megabytes,
>> > THEN switch over to AMP?
>> > No, you don't, he says rhetorically.  :)
>>
>> If the policy was defined as "prefer_amp after n seconds" we would get
>> the desired effect without having to do any counting in the kernel.
>
> In both cases we have to take in account the total size of the file, or
> the estimated time of transfer, so we can avoid to move to AMP when the
> transfer is about to end.

Right! Don't want to switch to AMP just to push those last 100 bytes :)

Since the kernel does not know the total object size to be transferred,
(right?), I've yet to come up with any 'threshold' ideas the kernel can
make. Note that the transfer could be one huge file or many small ones.

--
Tim Monahan-Mitchell
Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

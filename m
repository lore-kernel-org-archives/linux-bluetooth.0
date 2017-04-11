Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170410231041.vz35anezpzhscu4t@earth>
Date: Tue, 11 Apr 2017 13:36:44 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jslaby@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Message-Id: <4FEFA1D8-BE23-40FB-BAA3-3EC910FE9F96@holtmann.org>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
 <20170410231041.vz35anezpzhscu4t@earth>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

>>>>>> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
>>>>>> Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
>>>>>> they were queued by Tony. I also changed the patch order, so that the serdev
>>>>>> patches come first. All of them have Acked-by from Rob, so I think it makes
>>>>>> sense to merge them to serdev subsystem (now) and provide an immutable branch
>>>>>> for the bluetooth subsystem.
>>>>> 
>>>>> Greg doesn't read cover letters generally and since the serdev patches
>>>>> are Cc rather than To him, he's probably not planning to pick them up.
>>>> 
>>>> I wonder actually if we should merge all of these via bluetooth-next
>>>> tree with proper Ack from Greg. However it would be good to also get
>>>> buy in from Dave for merging this ultimately through net-next.
>>> 
>>> I don't really care where it goes.  I can take the whole thing in my
>>> tty/serial tree now if no one objects and I get an ack from the relevant
>>> maintainers {hint...}
>> 
>> I think it is better if it goes thru BT tree. I have another driver
>> converted that is dependent on this series. There's a couple other
>> serdev changes on the list too, but this shouldn't depend on them.
> 
> Is this waiting for something, or could it be queued to
> bluetooth-next then? It would be nice to finally have
> this in 4.12 :)

I would prefer if we can get an ACK from Greg. Then I merge it through the bluetooth-next tree.

Regards

Marcel


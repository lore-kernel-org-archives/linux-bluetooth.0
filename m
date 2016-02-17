Return-Path: <maxime.chevallier@openwide.fr>
Date: Wed, 17 Feb 2016 13:57:31 +0100
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: mgmt API, need some help for my use-case
Message-ID: <20160217125731.GA12237@vps217108.ovh.net>
References: <20160215081727.GA8190@vps217108.ovh.net>
 <17B4A1D4-8904-4599-AD91-4EC862C1753D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17B4A1D4-8904-4599-AD91-4EC862C1753D@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for the answer,
> Hi Maxime,
> 
> > I would like to discuss a use-case that I encountered on my project, and
> > for which I cannot find a right way to do it with mgmt API.
> > 
> > I have a controller, the 88W8887 that I need to set in 'wakeup host' mode.
> > 
> > I put my host in suspend-to-mem, and the controller toggles a GPIO to wake
> > it up under certain circumstances, including a Low Energy connection.
> > 
> > To do that, I need to :
> > 	- configure precisely my advertising intervals, to be in low duty
> > 	  cycle advertising, with a long interval between advertisements
> > 	- configure the filter policy, to only process connection
> > 	  requests from whitelisted devices ( we want only whitelisted
> > 	  devices to be able to wakeup our system ).
> > 
> > I previously did that with the HCI lib in my C program, and submitted a
> > patch to the hci lib, to add the le_set_advertising_parameters to the lib.
> > 
> > I used the following HCI commands :
> > 	- LE clear whitelist ( OCF 0x0010 )
> > 	- LE Add device to whitelist ( OCF 0x0011 )
> > 	- LE Set advertising parameters ( OCF 0x0006 )
> > 	- LE Set advertise enable ( OCF 0x000A )
> > 
> > It turns out this is not the right approach, Johan Hedberg explained to me
> > on IRC that the hci lib was not intended to be used by external programs.
> > 
> > Therefore, I'm looking for a way to do it using the mgmt API, but I can't
> > find a way to :
> > 	- Manipulate the whitelist
> > 	- Configure advertising intervals
> > 	- Configure the filter policy
> > 
> > If I missed something in the mgmt API that would allow me to do that, please
> > point it to me. If these are some missing features, I am willing to spend some
> > time working on it.
> 
> it sounds to me that Add Device with type 0x01 is actually what we really wanted to support here. We currently use that for directed connections. So maybe we introduce a type 0x03 which has different meaning on LE compared to 0x01, but for BR/EDR it would actually result in 0x03 defining the incoming connections type for both bearers. On the other hand, is anybody actually using type 0x01 for LE?
> 
> So only tricky part is that when using the whitelist for limiting LL_CONNECT_REQ processing is that we can then not background scan with a whitelist. Since that list might be different. So this is something we need to figure out on what chips actually do here. Or we have to create some combined whitelist and accept false positives that we handle in the host then.

I get what you mean for Add Device with Action 0x03, that would fit my needs.

I think however that there needs to be a way to specify if we take the
whitelist into account while scanning of advertising in connectable mode.

I fail to see when we should take the whitelist into account in the current
workflows proposed by the API. I get that blocking with Block Device
establishes a blacklist, that Add Device could be used to "whitelist" a
device, but I think there needs to be a way to set a mode where only
whitelisted devices are taken into account for discovery and connection.

Sorry if this is unclear, I don't have a full understanding of all the
mecanisms yet.

So when you say "accept false positives that we handle in the host", you
are talking about a BR/EDR device that is not whitelisted but that might
have been seen by the controller since it only takes LE addresses into
account in its whitelist ?

Thanks,

Maxime

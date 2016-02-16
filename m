Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: mgmt API, need some help for my use-case
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160215081727.GA8190@vps217108.ovh.net>
Date: Tue, 16 Feb 2016 10:17:08 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <17B4A1D4-8904-4599-AD91-4EC862C1753D@holtmann.org>
References: <20160215081727.GA8190@vps217108.ovh.net>
To: Maxime Chevallier <chevalliersebmax@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxime,

> I would like to discuss a use-case that I encountered on my project, and
> for which I cannot find a right way to do it with mgmt API.
> 
> I have a controller, the 88W8887 that I need to set in 'wakeup host' mode.
> 
> I put my host in suspend-to-mem, and the controller toggles a GPIO to wake
> it up under certain circumstances, including a Low Energy connection.
> 
> To do that, I need to :
> 	- configure precisely my advertising intervals, to be in low duty
> 	  cycle advertising, with a long interval between advertisements
> 	- configure the filter policy, to only process connection
> 	  requests from whitelisted devices ( we want only whitelisted
> 	  devices to be able to wakeup our system ).
> 
> I previously did that with the HCI lib in my C program, and submitted a
> patch to the hci lib, to add the le_set_advertising_parameters to the lib.
> 
> I used the following HCI commands :
> 	- LE clear whitelist ( OCF 0x0010 )
> 	- LE Add device to whitelist ( OCF 0x0011 )
> 	- LE Set advertising parameters ( OCF 0x0006 )
> 	- LE Set advertise enable ( OCF 0x000A )
> 
> It turns out this is not the right approach, Johan Hedberg explained to me
> on IRC that the hci lib was not intended to be used by external programs.
> 
> Therefore, I'm looking for a way to do it using the mgmt API, but I can't
> find a way to :
> 	- Manipulate the whitelist
> 	- Configure advertising intervals
> 	- Configure the filter policy
> 
> If I missed something in the mgmt API that would allow me to do that, please
> point it to me. If these are some missing features, I am willing to spend some
> time working on it.

it sounds to me that Add Device with type 0x01 is actually what we really wanted to support here. We currently use that for directed connections. So maybe we introduce a type 0x03 which has different meaning on LE compared to 0x01, but for BR/EDR it would actually result in 0x03 defining the incoming connections type for both bearers. On the other hand, is anybody actually using type 0x01 for LE?

So only tricky part is that when using the whitelist for limiting LL_CONNECT_REQ processing is that we can then not background scan with a whitelist. Since that list might be different. So this is something we need to figure out on what chips actually do here. Or we have to create some combined whitelist and accept false positives that we handle in the host then.

Regards

Marcel


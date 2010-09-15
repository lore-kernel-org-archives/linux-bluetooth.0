Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <4C8F160B.4010401@Atheros.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
	 <1284442946.2405.50.camel@localhost.localdomain>
	 <4C8F160B.4010401@Atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Sep 2010 12:44:24 +0900
Message-ID: <1284522264.2405.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> >> Below is the Sim Access Profile server role API discription.
> >> Please let me know your comments.
> >
> > my obvious question is why do we wanna do this over D-Bus and not
> > connect it directly to the hardware via a plugin?
> 
> You meant creating something like a tty device and let the hardware 
> connect directly to this?
> 
> The initial plan was to use a D-Bus file descriptor and transfer the SAP 
> packets to the agent over it.
> 
> The problem was the SAP packet format is specified by the Bluetooth SAP 
> spec. I could not relate it to any generic packet format ( Like HF, HS, 
> DUN can be mapped to an AT parser).
> 
> I am not sure if any existing card reader implementation could parse it 
> to extract SIM card related data (APDU) without additional support for it.
> 
> Another reason I thought about D-Bus was because, most of the SAP 
> operations are Request/Response type like Reset, SimOn etc.
> 
> It mapped better with a Method/Signal communication than packet transfer.
> 
> Some of the card reader implementation I checked had proprietary packet 
> format. So not sure how we could interface with them.
> >
> > Remember that SIM transaction are timing critical and just relaying them
> > over D-Bus doesn't sound the right approach right now. While of course
> > even bluetoothd can't guarantee and response time, it is clearly better
> > than over D-Bus.
> >
> 
> I would really appreciate if you can give me any idea about working 
> around the above mentioned issues.

if we talk about the SAP server role found in a mobile phone, then that
support clearly needs to interact with the telephony stack. Since when
SAP is active the telephony stack needs to be suspended and all SIM
transaction being forwarded.

Currently I would be thinking that the SAP implementation should be done
inside oFono actually. Since then you have direct access to the
hardware. The D-Bus approach just doesn't sound correct to me. I could
be of course wrong, but I can't wrap my mind around on how you can make
this work.

Even with file descriptor passing this doesn't look like the right
approach. If we need a hardware abstraction than we either use oFono or
we have to create some SAP hardware access abstraction.

The SAP client role found a carkit is obviously a different story.

Regards

Marcel



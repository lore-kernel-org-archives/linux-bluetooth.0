Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
From: Marcel Holtmann <marcel@holtmann.org>
To: Nicolas GUILBAUD <nicolas.guilbaud.wj@rdf.renesas.com>
Cc: Suraj Sumangala <suraj@Atheros.com>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	linux-bluetooth@vger.kernel.org,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
	 <1284442946.2405.50.camel@localhost.localdomain>
	 <4C8F160B.4010401@Atheros.com>
	 <1284522264.2405.89.camel@localhost.localdomain>
	 <4C906430.90900@Atheros.com>
	 <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 08:00:16 +0900
Message-ID: <1284678016.2405.145.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicolas,

> >>> I would really appreciate if you can give me any idea about working
> >>> around the above mentioned issues.
> >>
> >> if we talk about the SAP server role found in a mobile phone, then that
> >> support clearly needs to interact with the telephony stack. Since when
> >> SAP is active the telephony stack needs to be suspended and all SIM
> >> transaction being forwarded.
> >>
> >> Currently I would be thinking that the SAP implementation should be done
> >> inside oFono actually. Since then you have direct access to the
> >> hardware. The D-Bus approach just doesn't sound correct to me. I could
> >> be of course wrong, but I can't wrap my mind around on how you can make
> >> this work.
> >>
> >> Even with file descriptor passing this doesn't look like the right
> >> approach. If we need a hardware abstraction than we either use oFono or
> >> we have to create some SAP hardware access abstraction.
> >
> >The advantage I thought d-bus has would be the generic interface it 
> >could provide. But, if we have a system with direct access to the Sim 
> >access hardware, D-bus could possibly become a bottleneck.
> >
> >I would really appreciate if others who have worked with Sim Access and 
> >OFono can give their comments.
> >
> >Also, please share some information on regarding the SIM reader 
> >implementation in linux based systems.
> >
> >>
> >> The SAP client role found a carkit is obviously a different story.
>
> I agree with Marcel, because in standard Mobile phone implementation, the SIM card is directly connected to the Modem. To access the SIM card, AT command (or proprietary commands) are needed, oFono implements both of them to access SIM card in Modem side, but in my understanding there is no possibilities to disconnect modem (in oFono) due to SIM SAP.

that is just because we haven't gotten there yet. Of course if SAP takes
over we have to shutdown oFono's handling of the modem. This could be
done similar to the support for Lockdown we have in the oFono TODO list.

> In the case where SIM card is connected to the Application processor (Linux side), it's missing the SIM stack (APDU server...). I don't find any SIM implementation in Linux, may be we have to specify it. 

There is a framework for card services in general, but I think that is
just pure overhead for this.

And to be honest, my current thinking is that even for pure SIM card
readers with APDU mode, we might wanna support them via oFono anyway.
Having to add SAP support in multiple levels is a bad idea.

However in the end this all depends on the hardware and right now I have
not had access to SAP capable hardware. Or maybe I did and I didn't know
it yet. Do we have any target hardware in mind?

Regards

Marcel



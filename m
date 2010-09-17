Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Date: Fri, 17 Sep 2010 13:01:05 +0200
Message-ID: <A9AC1023FCA4654D92AC24C2A8F6A09201AA816C@renesas4bis.renesas-rdf.local>
In-Reply-To: <1284678016.2405.145.camel@localhost.localdomain>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <1284442946.2405.50.camel@localhost.localdomain> <4C8F160B.4010401@Atheros.com> <1284522264.2405.89.camel@localhost.localdomain> <4C906430.90900@Atheros.com> <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local> <1284678016.2405.145.camel@localhost.localdomain>
From: "Nicolas GUILBAUD" <nicolas.guilbaud.wj@rdf.renesas.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Suraj Sumangala" <suraj@Atheros.com>,
        "Suraj Sumangala" <Suraj.Sumangala@Atheros.com>,
        <linux-bluetooth@vger.kernel.org>,
        "Jothikumar Mothilal" <Jothikumar.Mothilal@Atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Message d'origine-----
De=A0: linux-bluetooth-owner@vger.kernel.org =
[mailto:linux-bluetooth-owner@vger.kernel.org] De la part de Marcel =
Holtmann
Envoy=E9=A0: vendredi 17 septembre 2010 01:00
=C0=A0: Nicolas GUILBAUD
Cc=A0: Suraj Sumangala; Suraj Sumangala; =
linux-bluetooth@vger.kernel.org; Jothikumar Mothilal
Objet=A0: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API =
description


>>that is just because we haven't gotten there yet. Of course if SAP =
takes
over we have to shutdown oFono's handling of the modem. This could be
done similar to the support for Lockdown we have in the oFono TODO list.

Do you have information about the release date of this feature? And =
about the interface to lockdown, is it a D-BUS message?=20


>There is a framework for card services in general, but I think that is
just pure overhead for this.

>And to be honest, my current thinking is that even for pure SIM card
readers with APDU mode, we might wanna support them via oFono anyway.
Having to add SAP support in multiple levels is a bad idea.

Yes but an APDU interface is needed in the SIM driver of oFono, I don't =
see any interface of this kind in the source code.

Maybe it's not the good place to speak about that.

>However in the end this all depends on the hardware and right now I =
have
not had access to SAP capable hardware. Or maybe I did and I didn't know
it yet. Do we have any target hardware in mind?

Yes we have, it's Renesas Modem solution.


Regards

Nicolas


--
To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

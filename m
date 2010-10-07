Return-Path: <cyrus@holtmann.org>
Subject: RE: Sim Access profile server implementation
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: suraj@atheros.com, linux-bluetooth@vger.kernel.org,
	Jothikumar.Mothilal@Atheros.com, joakim.xj.ceder@stericsson.com,
	arunkr.singh@stericsson.com
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com>
References: <1285657515.12097.7.camel@atheros013-desktop>
	 <1286265730.17473.29.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
	 <1286280767.17473.89.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B700111448097D01B6CF@EXMB04.eu.tieto.com>
	 <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 17:42:16 +0200
Message-ID: <1286466136.6145.159.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> >>Can you share that code with us. And also hardware if you. We 
> >are still 
> >>having hard time to find proper hardware to test this on.
> >
> >Will send a patch soon. I use 
> >http://www.stericsson.com/platforms/U8500.jsp hw, but need to 
> >check if I can share one with you.
> >
> 
> Here you are the patch. Just note that it is based on an old bluez 4.4x
> If you consider to accept the design I will update the patch upon the latest release. 

in general I am fine if we do this similar to what we do with the
different telephony backend. So yes, go ahead with this.

However, please clean this up. The patch needs a lot of work before it
would be ready upstream. And of course it requires a dummy SAP plugin as
well. Same as we do have for telephony.

Regards

Marcel



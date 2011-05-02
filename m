Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
From: Marcel Holtmann <marcel@holtmann.org>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144816F29AF32A@EXMB04.eu.tieto.com>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1304189166.15916.98.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B70011144816F29AF32A@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 May 2011 08:31:00 -0700
Message-ID: <1304350260.15916.102.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> >> @@ -482,6 +482,7 @@ PIN Code Request Event
> >>  Event Code		0x000E
> >>  Controller Index:	<controller id>
> >>  Event Parameters	Address (6 Octets)
> >> +			Secure (1 Octet)
> >
> >we do need to document possible values and their meanings. Is 
> >this a boolean or is this suppose to indicate the PIN code length?
> 
> It's boolean. 	
> Do you mean something like this?
> 
> Event Code		0x000E
> Controller Index:	<controller id>
> Event Parameters	Address (6 Octets)
> 			Secure (1 Octet)
> 
> 		Secure: 0x01  16 digit PIN code required
> 			0x00  16 digit PIN code not required

yes, we need these things documented.

Obviously now the question is why not expose this as min_pin_length
value?

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Wed, 1 Dec 2010 13:12:44 +0200
Subject: RE: [PATCH 1/2] Sim Access Profile API
Message-ID: <99B09243E1A5DA4898CDD8B7001114480BDADF1B1B@EXMB04.eu.tieto.com>
References: <1291113364-6401-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1291113364-6401-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1291200591.4795.95.camel@aeonflux>
In-Reply-To: <1291200591.4795.95.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=20

>From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
>Hi Waldemar,
>
>
>do we want this really as property? Wouldn't be configuration=20
>option be better to enable this. None of the other profiles=20
>has this anymore.=20

Well, that is actually a proposal and I don't see any problems if we go for=
 conf options in here. Even more, that would be if fact more usef-ull.  Is =
the main.conf a right place for say EnableSAP=3Dtrue option ?

>And if their server depends on external=20
>programs then it either goes via an agent or some method call=20
>that can be easily tracked.
>
I'm not sure I get it. Do you mean if an external program needs to enable s=
ap they will use method call?=20

Regards,
/Waldek

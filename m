Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Date: Wed, 4 May 2011 10:52:35 +0300
Subject: RE: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F2AEF2AB@EXMB04.eu.tieto.com>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1304189166.15916.98.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B70011144816F29AF32A@EXMB04.eu.tieto.com>
 <1304350260.15916.102.camel@aeonflux>
In-Reply-To: <1304350260.15916.102.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>yes, we need these things documented.
>
>Obviously now the question is why not expose this as=20
>min_pin_length value?
>

Well, that's another approach, but for us it's only essential if the pin is=
 16 digit or not. So, boolean it's enough in my opinion.
Moreover, if we go for min_pin_len a user should have a chance to set this =
value for instance an the socket. That means a new interface, obviously not=
 appreciated. Otherwise, min_pin_len will be 16 or 0 (length not important)=
.

Thanks,
Waldek

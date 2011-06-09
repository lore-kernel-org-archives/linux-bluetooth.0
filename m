Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>
Date: Thu, 9 Jun 2011 17:00:33 +0300
Subject: RE: [PATCH 1/2] Add RequestSecurePinCode to agent API
Message-ID: <99B09243E1A5DA4898CDD8B700111448175AA2DE35@EXMB04.eu.tieto.com>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1307615061.2589.36.camel@aeonflux>
In-Reply-To: <1307615061.2589.36.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>I do not like this since it is really legacy stuff and makes=20
>since really complicated. And now we are making big efforts to=20
>support this and that is bad. Since Simple Pairing solved this=20
>nicely for us.
>
>However I need to talk with Johan about this and figure something out.

That's what happen when we do something that should be done at the begining=
.=20
One good news, this seems like the last patchset in this topic :)

I agree with Luiz, it's good idea to do it in bluez 5.x by adding just new =
param in PinCodeRequest.

Waldek

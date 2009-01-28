Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Some kernel changes
From: Marcel Holtmann <marcel@holtmann.org>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: Nick Pelly <npelly@google.com>,
	Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
In-Reply-To: <ac290f760901280218q3eefc51es5e3b500c629f6c68@mail.gmail.com>
References: <496895AB.4050902@nokia.com>
	 <1232061946.15331.1.camel@californication>
	 <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
	 <1232099244.27758.4.camel@californication>
	 <ac290f760901201054r804f79dm5b03abf73e2e89cf@mail.gmail.com>
	 <DD78C3E4-03E2-417F-99B9-7D67B311C643@holtmann.org>
	 <ac290f760901201628u7f1f4fc7xf6fe21de90bdc194@mail.gmail.com>
	 <1232536752.26470.1.camel@californication>
	 <ac290f760901210946m444454b9we16a563c5f040471@mail.gmail.com>
	 <1233136775.2139.3.camel@violet>
	 <ac290f760901280218q3eefc51es5e3b500c629f6c68@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 11:35:50 +0100
Message-Id: <1233138950.2139.4.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

> >> >> >>>>> why do you wanna set AUTH_PENDING again. That is not needed we only
> >> >> >>>>> wanna know once encryption comes back on. If no in time, then we just
> >> >> >>>>> disconnect the link. That simple.
> >> >> >>>>>
> >> >> >>>>>>  b) I also see that we are not clearing the timer and hence after
> >> >> >>>>>> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
> >> >> >>>>>> even though the encryption has been established.
> >> >> >>>>>
> >> >> >>>>> Good catch. Fixed it.
> >> >> >>>>
> >> >> >>>> Cool.  Can you upload it to bluetooth-testing git ? I saw a related
> >> >> >>>> problem while looking at the timer issue and wanted to see if the fix
> >> >> >>>> takes care of it.
> >> >> >>>
> >> >> >>> I am in the process in doing so, but there are other important things
> >> >> >>> that need to be done first.
> >> >> >>
> >> >> >> Sorry to push you on this, is this patch been uploaded ?
> >> >> >
> >> >> > since a few days now. Check the bluetooth-testing.git and it is even rebased
> >> >> > against 2.6.29-rc2.
> >> >> >
> >> >> I applied the patches and I see that we actually don't pause the
> >> >> RFCOMM tx traffic because we don't check on
> >> >> the RFCOMM_SEC_PENDING flag when sending the tx packets in rfcomm_process_dlcs.
> >> >> I verified this using the "attest" command - we keep sending RFCOMM
> >> >> traffic even though encryption is off.
> >> >>
> >> >> Please look at the patch attached.
> >> >>
> >> >> Also should we drop the "rx" packets too  when the encryption is dropped ?
> >> >
> >> > can you get me a version with a proper commit message. Just the subject
> >> > is not gonna be good enough.
> >> >
> >>
> >> Sorry, its attached. Also like mentioned above the patch checks only
> >> while sending tx packets ?
> >> Should we drop "rx" packets also ?
> >
> > patch looks fine to me, but you need to fix/revert the comment change ;)
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index ae2ecaa..73ffc0c 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -1,4 +1,4 @@
> > -/*
> > +f*
> >    RFCOMM implementation for Linux Bluetooth stack (BlueZ).
> >    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> >    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> >
> > And I like to have a little bit more detailed commit message please.
> >
>    Sure I will resubmit
>    Also, should we drop the "rx" packets ?

no, we can't do that since RFCOMM support to be a reliable stream.

Regards

Marcel



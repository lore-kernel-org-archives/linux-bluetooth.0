Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Some kernel changes
From: Marcel Holtmann <marcel@holtmann.org>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: Nick Pelly <npelly@google.com>,
	Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
In-Reply-To: <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
	 <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
	 <1231873966.12234.2.camel@californication>
	 <ac290f760901151113jfd2d3b2t8bce890dd186ecbd@mail.gmail.com>
	 <1232061946.15331.1.camel@californication>
	 <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Jan 2009 10:47:24 +0100
Message-Id: <1232099244.27758.4.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > why do you wanna set AUTH_PENDING again. That is not needed we only
> > wanna know once encryption comes back on. If no in time, then we just
> > disconnect the link. That simple.
> >
> >>    b) I also see that we are not clearing the timer and hence after
> >> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
> >> even though the encryption has been established.
> >
> > Good catch. Fixed it.
> 
> Cool.  Can you upload it to bluetooth-testing git ? I saw a related
> problem while looking at the timer issue and wanted to see if the fix
> takes care of it.

I am in the process in doing so, but there are other important things
that need to be done first.

> The timer thats started in rfcomm_security_cfm (for the drop in
> encryption) does get cleared in rfcomm_process_dlcs
> but then we have some data to send.  So we send the RFCOMM PN packet
> just after encryption is re-established.
> This results in a new timer being started in rfcomm_process_dlcs and
> we don't get the UA packet to clear this timer and hence when
> the timer expires, the connection is dropped.

I think you are confusing the work-flow here. The initial stage here is
that we get security_cfm when establishing the connection. Then we will
either reject or accept the link depending if encryption is enabled or
not. In case of dropping encryption during an existing connection we
don't need to send PN again. We do have to be in BT_CONNECTED state to
have the encryption droping check to kick in. The SEC_PENDING only
ensures that we stay encrypted. It has nothing to with the auth step.
Also we combine auth+encrypt since one without the other makes no sense
at all. So the initial call of security_cfm will always include auth and
encrypt enabled.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
To: tmonahan@codeaurora.org
Cc: David Vrabel <david.vrabel@csr.com>,
	Inga Stotland <ingas@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com
In-Reply-To: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 11:53:20 -0700
Message-ID: <1280775200.12579.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

please fix your mail client to NOT break threading.

> >> AMP vs BR/EDR preference for L2CAP channel can be configured as command
> line argument using new option "-J". Possible values:
> >>                  "require_br_edr",
> >>                  "prefer_amp",
> >>                  "prefer_br_edr"
> >> If no preference indicated, the default is set to require BR/EDR.
> >
> > I think an explicit channel move command and a channel move complete
> event are what many applications/profiles will need to be able to use an
> AMP effectively.
> 
> A future AMP policy setting of "manual" could certainly give each
> application the freedom to move an l2cap channel at will, after applying
> its own decision making process. However, with that freedom comes the
> responsibility of processing the AMP related events and initiating the AMP
> commands to make the decision. For example, the application needs to know
> if AMP controllers are available both locally and remotely, which in turn
> requires initiating the AMP discovery process and looking over the
> available local HCI devices; a loss of the physical link event means the
> application must move the link back to BR/EDR, etc. All of the additional
> machinery to accomplish that could indeed be exposed for use by
> applications. I think such an approach, if really needed, would not
> conflict with these proposed policies that hide all of that within the
> kernel.
> 
> To illustrate how these policies simplify applications, consider OBEX. An
> OBEX server application would choose "prefer_br_edr", thus leaving the
> remote OBEX client to decide and initiate the channel move to an AMP, and
> thus granting advance permission to the kernel for the move to take place.
> The OBEX client could examine the size of an upcoming transfer and choose
> "prefer_amp", thereby instructing the kernel to initiate the move to an
> AMP if all local and remote conditions allow it. Thus, the OBEX client and
> server applications make simplistic decisions to set up AMP, and can focus
> on moving data over the l2cap channel, leaving the management of what
> medium the data flows over up to the kernel, who keeps it transparent. In
> this way, work to make an existing profile "AMP aware" is also minimal.
> 
> In the discussion with Marcel regarding our AMP proposal in March ("RFC:
> QuIC's AMP + eL2CAP Technical Plans"), where we had listed these AMP
> control policies, he seemed to indicate that these policies would
> automatically trigger AMP discovery within the kernel, which it will. As
> he said, "Less options are less confusing for users" (apologies in advance
> if I misinterpreted his answer).

my current approach here is still that we wanna do this automatically in
the background for the profiles. I think at most the profiles should
just provide a threshold for either a) staying on BR/EDR or b) moving
over to AMP.

I know that the Bluetooth SIG tries to define such policies as part of
the profiles (like FTP for example), but I think this makes sense. I
doubt the real usage of making this manual. A profile/application should
just give its preference or intent and then we try to accommodate them
as best as possible.

The other problem here is also that besides whatever the profiles wants,
it might happen that the WiFi policy is stronger and only allows using
the WiFi device as WiFi or as AMP. And if WiFi wins, then we have to rip
the AMP out of the system. At that point whatever the Bluetooth profiles
wanted is pointless since the AMP controller is gone anyway.

That said, nothing stops us from allowing to make our AMP polices
dynamic and allow the application to change it threshold during
lifetime. For example it starts out as BR/EDR only and then during the
usage of the link it decides that now AMP preferred would make sense. In
that sense you would have manual switching to some level.

Regards

Marcel



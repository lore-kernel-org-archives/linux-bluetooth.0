Return-Path: <cyrus@holtmann.org>
Message-ID: <1332179057.14217.215.camel@aeonflux>
Subject: Re: [PATCH] mgmt-api: add read Tx power level command
From: Marcel Holtmann <marcel@holtmann.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Mar 2012 10:44:17 -0700
In-Reply-To: <CA+XVXfcPy+N0JiJsJz5-sb+7re8Y6wSGfkygzSe68H0TtN3Z6A@mail.gmail.com>
References: <1331503837-19015-1-git-send-email-arik@wizery.com>
	 <1331512937.14217.74.camel@aeonflux>
	 <CA+XVXfeSUaXiRWNO68VaL7ZkRuJ3g-MxzBvVsViLVPfsNQqM6g@mail.gmail.com>
	 <1331573362.14217.78.camel@aeonflux>
	 <CA+XVXfcXqRZsnsEoBHtcn-sZVqe1E_Sfn4H-9ZRL7ZWU_ZWBOg@mail.gmail.com>
	 <CA+XVXfcPy+N0JiJsJz5-sb+7re8Y6wSGfkygzSe68H0TtN3Z6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

> >>> >> +     Controller Index:       <controller id>
> >>> >> +     Command Parameters:     Address (6 Octets)
> >>> >> +                             Address_Type (1 Octet)
> >>> >> +                             Type (1 Octet)
> >>> >> +     Return Parameters:      Address (6 Octets)
> >>> >> +                             Address_Type (1 Octet)
> >>> >> +                             Status (1 Octet)
> >>> >> +                             Level (1 Octet)
> >>> >> +
> >>> >> +     Possible values for the Address_Type parameter:
> >>> >> +             0       BR/EDR
> >>> >> +             1       LE Public
> >>> >> +             2       LE Random
> >>> >> +
> >>> >> +     Possible values for the Type parameter:
> >>> >> +             0       Current Transmit Power Level
> >>> >> +             1       Maximum Transmit Power Level
> >>> >
> >>> > Which ones do you care about? And why not just read both and return both
> >>> > at the same time.
> >>> >
> >>> > I think that I made this pretty clear multiple times already. The mgmt
> >>> > API is not for stuffing random HCI commands into it. Please explain your
> >>> > usage pattern of the results clearly.
> >>> >
> >>> > Who is triggering this command and who is consuming the results?
> >>>
> >>> Well the proximity reporter and proximity monitor profiles are the
> >>> ones using this (with LE connections only). The proximity monitor can
> >>> query the reporter for the Tx power level. The spec claims there's no
> >>> point in polling for this, as the value doesn't change during an LE
> >>> connection.
> >>
> >> so why are we not just reading that value when creating a LE connection?
> >> What is the penalty for doing it on every LE connection?
> >
> > Well presumably it should only be read when the TPS profile if
> > enabled. The cost is sending another command to the controller on each
> > connection. Not sure it's very high.
> > Maybe we can even integrate it into the "device connected" event, and
> > just read it for all connecting devices.
> >
> > I guess it's a matter of personal preference.
> >
> > I think this API is better for future proofing - it gives the caller
> > the option to get the Tx power for BR/EDR devices as well, at
> > arbitrary times (since it can change during a BR connection).
> > Some earlier emails suggested it might be useful.
> >
> >>
> >>> Both profiles only care about the current Tx power level. I added the
> >>> type for flexibility. It can be removed of course.
> >>>
> >>> In the proposed implementation the reporter reads this value when a
> >>> device connects and caches it. When a remote device asks for this
> >>> value (via an ATT read as part of the TPS profile), we return the
> >>> cached value.
> >>
> >> So it gets always read anyway.
> >
> > Only when TPS server is enabled.
> 
> Is the current API acceptable?

I don't know yet. Send a new version with detailed explanation and I
have another look. I am currently not fully convinced. I have the
feeling we should be doing this differently.

Regards

Marcel



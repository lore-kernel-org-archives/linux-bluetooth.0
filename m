Return-Path: <Michael.Albinus@alcatel.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: Printer adapter w/o SDP
References: <87acxxxly1.fsf@gmx.de> <1090178500.4400.25.camel@pegasus>
	<87wu11w1e3.fsf@gmx.de> <1090180872.4400.36.camel@pegasus>
	<nq7jt0m8wd.fsf@alcatel.de> <1090776708.31693.29.camel@pegasus>
From: Michael Albinus <michael.albinus@gmx.de>
Date: Mon, 26 Jul 2004 10:56:42 +0200
In-Reply-To: <1090776708.31693.29.camel@pegasus> (Marcel Holtmann's message
 of "Sun, 25 Jul 2004 19:31:48 +0200")
Message-ID: <nq8yd7m9it.fsf@alcatel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Michael,

Hi Marcel,

> thanks for the device. It was a bug in the SDP part of the Bluetooth
> library. The funny thing is that it was able to work with UUID128 and
> UUID16, but it seems that actually nobody used UUID32 for protocol
> identifiers before. The fix for that is in the CVS now.

Thanx for the fix. I'll check it next days.

> Regards
>
> Marcel

Best regards. Michael.

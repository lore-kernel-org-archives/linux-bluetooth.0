Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
Date: Wed, 30 Jul 2003 17:01:32 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Daryl Van Vorst <daryl@wideray.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RE: Rfcomm qualification
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1059601432.1832.9.camel@pegasus>
References: <000501c356b7$2887faf0$1a01010a@baked>
	<000501c356b7$2887faf0$1a01010a@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 02:43 PM 7/30/2003, Marcel Holtmann wrote:
>Hi Daryl,
>
>> Will making the default value of credits zero break other things?
>
>I got some time to test this and it brings our RFCOMM code back to the
>behavior of 1.0b.

>The session wide credits value is useless 
No, it's not. 1.1 spec only mandates send PN for the _first_ DLC
on that session. Which means that values negotiated in PN request are supposed 
to be applied to the subsequent DLCs.  So we still need session wide settings.
We just need to update them when we get PN req/rsp, which don't do.

Check this out:
"
6.5.1 Initial DLC Negotiation
The use of credit based flow control is a session characteristic. Thus, it has to
be negotiated with the PN multiplexor control command (see Section 5.5.3)
before the first DLC is established.
After the first successful negotiation and DLC establishment, all DLCs will be
flow controlled with this scheme. PN negotiation at subsequent DLC establish-ments
is optional, but recommended, since it also establishes initial credit
count values on both sides for both sides.
"

>and the dlc credits value must be zero in the initial place. 
Yep. But it doesn't really matter because we'll simply use session 
value as default.

>But we must make sure that we request 1.1 credit based 
>flow control for outgoing connections.
That's why session has to have non zero value by default.

>The attached patch should solve all problems.
>Max, please review the patch to make sure I don't forget anything.
It's incorrect.

Max

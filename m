Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030805095818.0c229058@unixmail.qualcomm.com>
Date: Tue, 05 Aug 2003 10:10:54 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RE: Rfcomm qualification
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1059612533.1832.48.camel@pegasus>
References: <5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
	<000501c356b7$2887faf0$1a01010a@baked>
	<000501c356b7$2887faf0$1a01010a@baked>
	<5.1.0.14.2.20030730162942.053ff898@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:48 PM 7/30/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >The session wide credits value is useless 
>> No, it's not. 1.1 spec only mandates send PN for the _first_ DLC
>> on that session. Which means that values negotiated in PN request are supposed 
>> to be applied to the subsequent DLCs.  So we still need session wide settings.
>> We just need to update them when we get PN req/rsp, which don't do.
>> 
>> Check this out:
>> "
>> 6.5.1 Initial DLC Negotiation
>> The use of credit based flow control is a session characteristic. Thus, it has to
>> be negotiated with the PN multiplexor control command (see Section 5.5.3)
>> before the first DLC is established.
>> After the first successful negotiation and DLC establishment, all DLCs will be
>> flow controlled with this scheme. PN negotiation at subsequent DLC establish-ments
>> is optional, but recommended, since it also establishes initial credit
>> count values on both sides for both sides.
>> "
>
>memory malfunction ;) I thought it was a per dlc value.
>
>The attached patch sets the default values for session and dlc credits
>to zero and put in RFCOMM_MAX_CREDITS only if we receive a PN with 1.1
>flow control.
>
>What do you think?

I don't like this:

@@ -746,7 +746,7 @@
        pn->ack_timer   = 0;
        pn->max_retrans = 0;
 
-       if (d->credits) {
+       if (cr || d->credits) {


This basically means that we'll always request CFC even if the other side
explicitly told us that they don't support it. Which is kinda dumb :).

Here is what I would do (no time for the patch sory).
When session is created set s->credits to -1. Replace above if() statement 
with
        if (s->credits < 0) {

Also rfcomm_apply_pn() needs to set d->credits only once at the end of the function.

Max

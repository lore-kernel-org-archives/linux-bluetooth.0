Return-Path: <cyrus@holtmann.org>
Message-ID: <20071220102046.7h0duacmskwgkc8g@v1539.ncsrv.de>
Date: Thu, 20 Dec 2007 10:20:46 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP services cannot be unregistered
References: <200712192341.02293.post@hendrik-sattler.de>
	<1198107273.8050.228.camel@aeonflux>
	<200712200229.40589.post@hendrik-sattler.de>
	<1198116580.8050.232.camel@aeonflux>
In-Reply-To: <1198116580.8050.232.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
List-ID: <bluez-devel.lists.sourceforge.net>

Quoting Marcel Holtmann <marcel@holtmann.org>:
>> https://www.hendrik-sattler.de/svn/obexpushd/trunk/
>>
>> I see this since about 3.11 when that entered Debian testing,  =20
>> current is 3.22.
>> I assume that the embedded SDP server might be the cause, at least Debian
>> uses it. BTW: kdebluetooth has the same problem.
>> I also reported that as Debian bug report
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D445677
>
> first of all you are using the unregister function wrongly. You have to
> give it the exact record structure you gave the register function. So
> when you allocate a new record, then the unregister has no idea what to
> do with it.

bt_sdp_obexpush() does create a new record structure but with the =20
exact same parameters (actually no variable parameters at all). The =20
resulting records should fully match, at least I assume that. The =20
record ID is then stored in the session_t value, I assume.
Or are pointer addresses matched, too?

> Why it doesn't cleanup after program termination is unclear to me. That
> should actually work. You might wanna investigate on that one.

Before this came up, I did not unregister or close at all and =20
everything was fine when the program was killed (SDP record was gone).
Can you give me a hint where this is actually processed, bluez-libs or =20
bluez-utils?

Thanks

HS

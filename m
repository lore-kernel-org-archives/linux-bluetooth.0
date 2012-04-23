Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Cc: "Mike" <puffy.taco@gmail.com>,
	"linux-bluetooth" <linux-bluetooth@vger.kernel.org>
References: <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>	 <1335035377.16897.340.camel@aeonflux>	 <CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>	 <1335042808.16897.350.camel@aeonflux>	 <CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>	 <1335125337.16897.357.camel@aeonflux>	 <CAB7rCTgLNv=BUznKMN3hU3NM_7odUsoELC2LZGYFwX6Xqawg5Q@mail.gmail.com>	 <1335130524.16897.365.camel@aeonflux>	 <20120422222246.GA27438@x220.P-661HNU-F1>	 <1335164553.16897.371.camel@aeonflux> <20120423091402.GA5758@x220> <1335174046.16897.374.camel@aeonflux>
In-Reply-To: <1335174046.16897.374.camel@aeonflux>
Subject: RE: PTS / linkkey issue
Date: Mon, 23 Apr 2012 15:46:58 -0700
Message-ID: <05a501cd21a3$083836a0$18a8a3e0$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Monday, April 23, 2012 2:41 AM
> To: Johan Hedberg
> Cc: Mike; linux-bluetooth
> Subject: Re: PTS / linkkey issue
>=20
> Hi Johan,
>
> > I don't think it's a good idea to mix the security level
> > (MITM/no-MITM) requirement with the permanence requirement
> > (no-bonding/bonding). Those really are and should remain as =
orthogonal
> > requirements. Even though OPP is the only profile we know that it's
> > natural to use no-bonding for there may well be use cases where you
> > want a secure connection for sensitive data but want to forget about
> > the security relationship once the connection is gone.
> >
> > I also think this is what the core spec intends since you've got the
> > option of no-bonding with MITM and no-bonding without MITM. Even the
> > table (5.7, page 1671) that defines the security levels talks =
nothing
> > about the permanence of the link key but only about authenticated vs
> > unauthenticated and MITM vs no MITM. Mixing the no-bonding stuff =
into
> > the security level would then also confuse anyone thinking that our
> > security levels are mappings to how the core spec defines them to =
be.
>=20
> fair point. Let them get the PTS fixed.
>=20
> However we could add an extra option to the security field that would =
make
> it depend on the pairing setting. This is all still speculation since =
we have no
> idea if it would not break GAP qualification.
>=20
> Regards
>=20
> Marcel


Hi All -

Out of curiosity, what is the PIXIT value TSPX_delete_link_key set to?

>From the discussion that has been going on here, I think it should set =
to FALSE in all of the profiles where you want the bonding to persist.

As you might guess from its name: TSPX_delete_link_key set to TRUE will =
delete the stored link key at the start of a test case. In other words, =
delete the bonding. TSPX_delete_link_key set to FALSE will leave the =
stored link key in place and use it during the authentication process -- =
that is, using the existing bonding.

There are some issues with selecting the proper security mode and I/O =
Capabilities. Part of it >>> seems <<< to be related to the security =
module in our host stack ignoring the security configuration we send =
down from the test cases. ("Seems" because it feels that way to me but I =
have no hard evidence.)

For the issues that have been reported, some combination of =
TSPX_delete_link_key is a workaround. Sometimes it works best to set it =
one way, sometimes the other.

At times, setting it to TRUE to trigger a pairing process and then =
setting it to FALSE works best.

Because of the available workaround, the issues that Mike mentioned =
earlier have not been given a high priority. A general review/repair of =
the security management situation is on my list of projects for later =
for this year. It may get bumped up in priority due to some other work I =
am doing where I need "fine granularity" control over the security =
configuration.


So, in summary, play with TSPX_delete_link_key and see if that helps. I =
know that it's not a satisfying solution, I >>> personally <<< don't =
like it either. But, a workaround is a workaround until something better =
comes along :-).

Cheers!

--- tom
tom allebrandi
wyrles@ytram.com

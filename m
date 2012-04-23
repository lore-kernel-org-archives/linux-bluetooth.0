Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 12:14:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: PTS / linkkey issue
Message-ID: <20120423091402.GA5758@x220>
References: <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
 <1335035377.16897.340.camel@aeonflux>
 <CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
 <1335042808.16897.350.camel@aeonflux>
 <CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>
 <1335125337.16897.357.camel@aeonflux>
 <CAB7rCTgLNv=BUznKMN3hU3NM_7odUsoELC2LZGYFwX6Xqawg5Q@mail.gmail.com>
 <1335130524.16897.365.camel@aeonflux>
 <20120422222246.GA27438@x220.P-661HNU-F1>
 <1335164553.16897.371.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335164553.16897.371.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Apr 23, 2012, Marcel Holtmann wrote:
> > > the real problem that you are seeing here is that the disappearing of
> > > the BlueZ devices and with that the oFono modem is actually fully
> > > intentional. It boils all down to the no bonding pairing. The device
> > > never gets marked as bonded.
> > > 
> > > I honestly have no idea on how to workaround this issue. My only idea is
> > > that we combine the access to a RFCOMM server channel with a re-pairing
> > > to upgrade this to general bonding. Problem is just that I have no idea
> > > if this would fly with the GAP qualification or not. Or if we would
> > > break that one then.
> > 
> > This whole thing looks so obviously as a PTS issue to me that I don't
> > see why anyone should spend any effort on anything else than raising an
> > errata for the PTS.
> > 
> > As far as what you're suggesting as a potential workaround it still
> > wouldn't guarantee that the PTS would start giving an authentication
> > requirement other than no-bonding. We can only control our own
> > authentication requirement.
> > 
> > Furthermore, you couldn't have this as general RFCOMM server behavior
> > since there are servers for which no-bonding may be desirable, like OPP,
> > and clients might not be tested to handle rejecting our general bonding
> > request properly if they were designed to assume they can get by with
> > their initial no-bonding request.
> 
> I was considering that if pairing is allowed and security is either
> medium or high, then we force a repairing if the link key is temporary.
> 
> Something like in the area of a no bonding link key is only allowed to
> connect a security low service. And if pairing is not allowed and you
> try to access a medium or high security service with no bonding, you
> will just get rejected.

I don't think it's a good idea to mix the security level (MITM/no-MITM)
requirement with the permanence requirement (no-bonding/bonding). Those
really are and should remain as orthogonal requirements. Even though OPP
is the only profile we know that it's natural to use no-bonding for
there may well be use cases where you want a secure connection for
sensitive data but want to forget about the security relationship once
the connection is gone.

I also think this is what the core spec intends since you've got the
option of no-bonding with MITM and no-bonding without MITM. Even the
table (5.7, page 1671) that defines the security levels talks nothing
about the permanence of the link key but only about authenticated vs
unauthenticated and MITM vs no MITM. Mixing the no-bonding stuff into
the security level would then also confuse anyone thinking that our
security levels are mappings to how the core spec defines them to be.

Johan

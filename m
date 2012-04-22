Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 01:22:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: PTS / linkkey issue
Message-ID: <20120422222246.GA27438@x220.P-661HNU-F1>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
 <1335004527.16897.337.camel@aeonflux>
 <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
 <1335035377.16897.340.camel@aeonflux>
 <CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
 <1335042808.16897.350.camel@aeonflux>
 <CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>
 <1335125337.16897.357.camel@aeonflux>
 <CAB7rCTgLNv=BUznKMN3hU3NM_7odUsoELC2LZGYFwX6Xqawg5Q@mail.gmail.com>
 <1335130524.16897.365.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335130524.16897.365.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Apr 22, 2012, Marcel Holtmann wrote:
> the real problem that you are seeing here is that the disappearing of
> the BlueZ devices and with that the oFono modem is actually fully
> intentional. It boils all down to the no bonding pairing. The device
> never gets marked as bonded.
> 
> I honestly have no idea on how to workaround this issue. My only idea is
> that we combine the access to a RFCOMM server channel with a re-pairing
> to upgrade this to general bonding. Problem is just that I have no idea
> if this would fly with the GAP qualification or not. Or if we would
> break that one then.

This whole thing looks so obviously as a PTS issue to me that I don't
see why anyone should spend any effort on anything else than raising an
errata for the PTS.

As far as what you're suggesting as a potential workaround it still
wouldn't guarantee that the PTS would start giving an authentication
requirement other than no-bonding. We can only control our own
authentication requirement.

Furthermore, you couldn't have this as general RFCOMM server behavior
since there are servers for which no-bonding may be desirable, like OPP,
and clients might not be tested to handle rejecting our general bonding
request properly if they were designed to assume they can get by with
their initial no-bonding request.

Johan

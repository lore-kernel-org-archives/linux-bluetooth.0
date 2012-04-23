Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335164553.16897.371.camel@aeonflux>
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
	<20120422222246.GA27438@x220.P-661HNU-F1>
	<1335164553.16897.371.camel@aeonflux>
Date: Mon, 23 Apr 2012 11:24:06 +0300
Message-ID: <CABBYNZK9ne2wae=LsO_uxMXR3KvHeLUMGOKYo8EBLeadv0T8WA@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Apr 23, 2012 at 10:02 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> I was considering that if pairing is allowed and security is either
> medium or high, then we force a repairing if the link key is temporary.
>
> Something like in the area of a no bonding link key is only allowed to
> connect a security low service. And if pairing is not allowed and you
> try to access a medium or high security service with no bonding, you
> will just get rejected.
>

But the reattempt could possible generate a no bonding again and if we
just reject it might cause more IOP problems.

@Mike: You can mark the device as non-temporary by calling
Adapter.CreateDevice, bluetoothd will attempt to do another sdp browse
but it should be fine for PTS as we do reversed sdp anyway when
someone pair to us, I guess that would work as workaround for
qualification but I wouldn't enable this behavior on production.

-- 
Luiz Augusto von Dentz

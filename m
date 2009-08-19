Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Aug 2009 08:44:46 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd does not autostart on boot
Message-ID: <20090819084446.41bc0578@stoetzler>
In-Reply-To: <1250630036.12900.109.camel@localhost.localdomain>
References: <20090818163341.60dc3fe1@stoetzler>
	<1250630036.12900.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 18 Aug 2009 22:13:56 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Tue, 2009-08-18 at 16:33 +0200, Stefan Seyfried wrote:

> > So the question is: how should we handle this upstream? Or should
> > every distribution roll her own solution?

This question still remains.

> We do the same because what Kay told me would work doesn't actually
> work. Having already spent a huge amount of time trying to make this
> work, I had no option but to add the same work-around as Ubuntu.
> 
> FWIW, I already had a conversation with Kay through Harald Hoyer,
> where Kay tried to deny that he ever told me that it would work (or
> rather, that it would work, but that we should do it another way in
> the future).
> 
> You can discuss that with him.

I'm not trying to play the blame game here (sorry if I made that
impression), I'm just trying to:

a) keep "my" package as close to Marcel's upstream as possible
b) make it work for everyone, even for those who install from source.

Since udev does not really do what we expected it to do, shouldn't we
add that very simple init script back to the tarballs?
(I expect it to do no harm, it will not even measurably impact the
"fast boot" efforts).

Best regards,

	Stefan
-- 
Stefan Seyfried
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)

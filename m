Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <20110515163257.GE1315@kroah.com>
References: <1305040215-712-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<BANLkTinAtUQ8H1DQpqXxX_U4mLO617L3Eg@mail.gmail.com>
	<20110515163257.GE1315@kroah.com>
Date: Sun, 15 May 2011 19:29:04 +0200
Message-ID: <BANLkTi=hN6NeLdXAjzeeYwcZR7+BoJ1BQg@mail.gmail.com>
Subject: Re: [PATCH v6] Add ST-Ericsson CG2900 driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Greg KH <greg@kroah.com>
Cc: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, devel@driverdev.osuosl.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Vitaly Wool <vitalywool@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>, Lee Jones <lee.jones@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/15 Greg KH <greg@kroah.com>:

> That's why you should only use staging as a last resort, not as your
> primary way of getting code into the kernel, especially for stuff with
> a constantly changing in-kernel interface like you have pointed out
> here.

Agree 100%

Trust me, we tried this already.

> Just do the "real work" first and get it merged the real way if at all
> possible.

This driver development has gone into statis due to conflicts and
endless discussions pertaining to the HCI transport layer
beneath it.

It was my recommendation to put it into staging, by doing this
people can talk about the architecture by submitting *patches*
to show how they want it instead of these fruitless discussions.

So this should be a case where staging really helps, at least in
my dreams.

Linus Walleij

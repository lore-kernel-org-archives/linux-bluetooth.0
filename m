Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 10:36:44 -0700
From: Greg KH <greg@kroah.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>,
	devel@driverdev.osuosl.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Vitaly Wool <vitalywool@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@sify.com>,
	Lee Jones <lee.jones@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v6] Add ST-Ericsson CG2900 driver
Message-ID: <20110515173644.GA18241@kroah.com>
References: <1305040215-712-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <BANLkTinAtUQ8H1DQpqXxX_U4mLO617L3Eg@mail.gmail.com>
 <20110515163257.GE1315@kroah.com>
 <BANLkTi=hN6NeLdXAjzeeYwcZR7+BoJ1BQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTi=hN6NeLdXAjzeeYwcZR7+BoJ1BQg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, May 15, 2011 at 07:29:04PM +0200, Linus Walleij wrote:
> It was my recommendation to put it into staging, by doing this
> people can talk about the architecture by submitting *patches*
> to show how they want it instead of these fruitless discussions.
> 
> So this should be a case where staging really helps, at least in
> my dreams.

Yes, that is where staging should help, hopefully we can get these build
dependancies worked out to get this merged properly.  Perhaps for the
.41 merge window?

thanks,

greg k-h

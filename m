Return-Path: <pavel@ucw.cz>
Date: Wed, 17 Aug 2016 17:54:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Message-ID: <20160817155452.GA14957@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org>
 <20160816135155.GA20948@rob-hp-laptop>
 <20160816232855.qgempm64zgp36ufd@earth>
 <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> >> > +  - reset-gpios:           Should specify the gpio for bluetooth reset
> >> > +  - host-wakeup-gpios:             Should specify the gpio for host wakeup
> >>
> >> Should be interrupt instead?
> >
> > Yes this is mostly an interrupt, but I need to read the current
> > line state.
> 
> When? If the interrupt is level triggered, then you can get the line
> state based on whether you get an interrupt or not. If this needs to
> be a wakeup source (see the wakeup source binding), then it needs to
> be an interrupt.

What is wrong with GPIO? It is simply a piece of wire. Yes, we'll
configure it to generate an interrupt, or maybe not, but that's
software detail, the device tree just should not care....
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <cyrus@holtmann.org>
Subject: Re: Data on eglib vs glib, implications for embedded use of bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org,
	Iliyan Malchev <malchev@google.com>,
	Brian Swetland <swetland@google.com>
In-Reply-To: <35c90d960809191823h47b491fegb0efd29d15f166df@mail.gmail.com>
References: <35c90d960809191520n2067753cs71c07d37ea83b28@mail.gmail.com>
	 <1221871191.6782.79.camel@californication>
	 <35c90d960809191823h47b491fegb0efd29d15f166df@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 22 Sep 2008 03:29:19 +0200
Message-Id: <1222046960.6782.137.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >> I guess it comes down to whether Bluez wants to support an embedded
> >> configuration. If Bluez is happy to abandon embedded, then they can
> >> forget eglib. But it Bluez is serious about supporting embedded
> >> configurations, it should keep eglib as a supported option in my
> >> opinion.
> >>
> >> I understand that one concern about eglib support is a lack of
> >> maintenance. I would be happy to help out with eglib support.
> >
> > I can bring up a project that contains eglib and we maintain it outside
> > of bluez-4.x source code. You just have to install it first and if you
> > use pkg-config you would have a perfect drop-in replacement. If you
> > compile it by yourself you do whatever fits best.
> >
> >> If supporting eglib is not an option, I am very much interested to
> >> hear the specific reasons as to why not. Is it due to eglib bugs? lack
> >> of eglib features (which ones)? or is embedded just not significant
> >> enough to be a concern?
> >
> > As long as eglib has the same API as GLib it is not a problem of support
> > at all. We do that already. The main reason why we removed it from the
> > source code was that it just became a maintenance nightmare.
> >
> > Do you have a problem to maintain it in a separate source tree and
> > release it as separate packages?
> 
> The danger, as I suggested earlier, is that Bluez developers will
> start using API's that are not already implemented in eglib, and do
> not make sense to implement on an embedded platform.
> 
> I do not mind maintaining eglib, but I don't want it to become as
> bloated as glib. Bluez needs to make a commitment to only use the
> parts of the glib API that makes sense on embedded platforms as well
> as Desktop platforms. Perhaps in Portland we can go through the API
> and work out what parts of the API that would be.
> 
> If Bluez as a project could make that commitment, then I would be
> happy to maintain eglib in a separate source tree.

it will not happen that BlueZ makes such a commitment. BlueZ works
perfectly fine on embedded systems and GLib is not as bloated as you
thing. You just happen to have a specific and limited use case scenario.
If we start to use functions not implemented in eglib, then you have to
implement them. That is what we were doing for the last 3 years and it
slowed down the development of BlueZ. This is why non of the BlueZ
developers are doing this anymore.

I created the initial tree for eglib at kernel.org:

	http://git.kernel.org/?p=bluetooth/eglib.git;a=summary

Feel free to sent me patches against it.

And just to make this perfectly clear, bashing against GLib doesn't help
at all. You either go ahead and make GLib more suitable for your needs
or you do this in eglib. Just using kernel features like epoll, timerfd
etc. would help you a lot to achieve your goal. Just make sure eglib is
API compatible.

I take care of the release process of eglib, but no other BlueZ
developer can be bothered with eglib details.

Regards

Marcel



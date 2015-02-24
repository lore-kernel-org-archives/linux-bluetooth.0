Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Feb 2015 12:37:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery
 method.
Message-ID: <20150224103753.GA6088@t440s.lan>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
 <CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
 <20150223130923.GA28722@t440s.lan>
 <CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Feb 23, 2015, Jakub Pawlowski wrote:
> > Since we can't any more track multiple different discoveries within the
> > same application (D-Bus connection) the StopDiscovery behavior is now
> > quite broken. The simplest way around that would be to add a discovery
> > instance return parameter to StartServiceDiscovery and to have a new
> > StopServiceDiscovery D-Bus method that'd take this as an input
> > parameter.
> 
> Right now each application can call StartDiscovery only once, I want
> each application to be able to call StartDiscovery OR
> StartFilteredDiscovery only once. This way we are completly fine with
> one StopDiscovery method. If some application needs to change filter,
> it can always stop and restart it's scan.

Actually I remembered wrong how the current code works. I thought it was
allowing multiple StartDiscovery() per app, but there's indeed a
hard-coded limit of just one. Keeping this policy around would allow
StopDiscovery to be used for StartDiscovery and StartServiceDiscovery
alike, and each app would then only be allowed to call one of those at a
time.

Johan

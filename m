Return-Path: <SRS0+8d78c3961b6b2a5ec5cb+262+infradead.org+dwmw2@pentafluge-183322.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084382951.25099.89.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084383201.4426.374.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 18:33:21 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 19:29 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > > I have no problem with that, but for the upstream package I am going to
> > > keep it this way. If you aren't a developer then you start the daemons
> > > at boot and kill them at shutdown. That's all.
> > 
> > I'm not sure I agree. I'm not a developer; I'm a point'n'drool user. I
> > run system-config-services and want to turn on 'pand' or 'dund' which
> > are configured as clients by default so all I have to do is turn them on
> > and they work...
> 
> actually the intention of the pand and dund options in the init script
> are for server use. You can use them for client setup, but I prefer to
> use something extra for that. This is of course not covered.

True. And there's a little bit more to be done before the point'n'drool
user will be able to enable them like that for server mode. But still,
it's nice to have them separate and I think that's what we'll do in
Fedora unless you really object. 

-- 
dwmw2

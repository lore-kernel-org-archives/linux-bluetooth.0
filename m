Return-Path: <SRS0+188c404e535cb8b986b7+281+infradead.org+dwmw2@pentafluge-234334.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1086042128.4690.16.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
	 <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
	 <1085937625.4462.5.camel@localhost.localdomain>
	 <1086042128.4690.16.camel@pegasus>
Content-Type: text/plain
Date: Mon, 31 May 2004 23:43:27 +0100
Message-Id: <1086043407.19763.6.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-06-01 at 00:22 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > This patch adds support to pand for writing a pidfile and cleaning up
> > the client connection on exit. I'll go play with initscripts next...
> 
> I applied this patch with some small modifications. And btw you forgot
> the diff for the man page ;)

Hmm. For once I actually did that -- but evidently forgot to send it.

> I don't like --autokill and -a option. I named it --autozap and used -z
> as option.

OK.

> If you don't modify main_sopts, this won't work.

Mea culpa. I tested it with long options only, and of course it works
like that :)

-- 
dwmw2

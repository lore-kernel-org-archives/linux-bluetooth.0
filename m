Return-Path: <SRS0+3cc931069eec9f4fa12c+270+infradead.org+dwmw2@pentafluge-101522.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084383929.25099.94.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 20 May 2004 10:15:21 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 19:45 +0200, Marcel Holtmann wrote:
> I am thinking of a dynamic and generic config interface to every daemon,
> but this is far from any real code at the moment. So feel free to do
> what you think is the best for Fedora.

OK, I've moved pand, dund and hidd into separate init scripts for
Fedora. 

Updated bluez-* RPMS for FC2/ppc are in my yum repository at
ftp://ftp.uk.linux.org/pub/people/dwmw2/fc2-mac/ (for i386 you'll want
to rebuild them from the SRPMS which are also there). I'll probably push
those as updates for FC2 too.

In fact, I suspect that the right answer for pand is to tie it into the
initscripts and system-config-network, so you add an interface of type
'PAN slave' or 'PAN master' and the network scripts handle starting and
stopping the daemon like they do ipppd, rather than doing it from a SysV
init script. I haven't used dund so I'm less sure about that but it
might also be the right approach there.

-- 
dwmw2

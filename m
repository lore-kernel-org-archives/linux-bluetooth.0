Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-devel] libtool and autoconf versions
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074650005.7088.56.camel@pegasus>
References: <1074424282.16573.52.camel@saag>
	 <1074632525.1707.181.camel@localhost>  <1074632708.23181.56.camel@saag>
	 <1074633031.1707.190.camel@localhost>  <1074650005.7088.56.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074650832.23181.93.camel@saag>
Mime-Version: 1.0
Date: Wed, 21 Jan 2004 02:07:12 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-01-21 at 01:53, Marcel Holtmann wrote:
> Hi Edd,
> 
> > > I'm talking about what's shipped in the tarballs, which uses
> > > libtool1.4.  Packagers for distros rely on the tarball releases.  In the
> > > (admittedly) unlikely event that changes need to be made and autoconf
> > > re-run for the purposes of packaging, the old ac and libtool would be
> > > needed.
> > I see. Yeah, I think we should release our tarballs with new autoconf. 
> > Marcel, it's time for you to upgrade ;-).
> 
> what version of libtool and autoconf is used for Debian Woody?

libtool1.4, autoconf2.53

>  Do Debian
> Sarge already uses the new versions?

sarge (and unstable) have autoconf2.59, libtool1.5

-- Edd

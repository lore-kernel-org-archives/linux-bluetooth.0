Return-Path: <SRS0+cd78f81f0a36eea3fb57+355+infradead.org+dwmw2@baythorne.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092387952.28711.217.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
	 <1092311388.28711.117.camel@pegasus>
	 <1092312127.15466.211.camel@hades.cambridge.redhat.com>
	 <1092317787.28711.150.camel@pegasus>
	 <1092384465.4186.37.camel@imladris.demon.co.uk>
	 <1092387952.28711.217.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092388491.4186.103.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 10:14:51 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-08-13 at 11:05 +0200, Marcel Holtmann wrote:
> if this is true, then this makes your patch useless. However after doing
> some research in this area it seems that I must use -fPIE and then link
> with -pie. This actually only works for programs, because libtool don't
> uses these extra flags.
> 
> Check out the CVS. The patch for that is already included.

OK, thanks. I'll try to put a package through the build system today.

> > > And please don't do this
> > > 
> > >         # Authentication and Encryption
> > > -       #auth enable;
> > > -       #encrypt enable;
> > > +       auth enable;
> > > +       encrypt enable;
> > > 
> > > in the bluez-utils-2.3-conf.patch. If you do that then you are going to
> > > set your local device in security mode 3 and this is not what you want.

Thanks for the explanation. I'll turn those off in the next build too.

-- 
dwmw2

Return-Path: <SRS0+568a86f7f2f31b2d34f2+355+infradead.org+dwmw2@pentafluge.srs.infradead.org>
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
Message-Id: <1092397956.10618.102.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 12:52:36 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-08-13 at 11:05 +0200, Marcel Holtmann wrote:
> > You also need -fpic in CFLAGS, I believe.
> 
> if this is true, then this makes your patch useless. 

I was overriding CFLAGS when I invoked make, because otherwise other
stuff (like -m32) gets omitted. Can we do this in acinclude.m4?

-	CFLAGS="-Wall -O2"
+	if (test "${CFLAGS}" = ""); then
+		CFLAGS="-Wall -O2"
+	fi
+

> However after doing some research in this area it seems that I must
> use -fPIE and then link with -pie. This actually only works for
> programs, because libtool don't uses these extra flags.

You can also use -fpic instead of -fPIE, apparently.

> Check out the CVS. The patch for that is already included.

OK. I think I'm not supposed to ship a cvs snapshot -- I have to wait
for 2.10. But I've isolated just the patch in question and added it into
the bluez-utils-2.9-2 RPM, with the above change to inherit CFLAGS if
they're already set.

The SRPM and ppc build are already at
ftp://ftp.uk.linux.org/pub/people/dwmw2/fc2-mac/ and the builds for
other less interesting architectures will turn up in rawhide in the
morning.

> > > What is the best way to detect PIE support in the compiler?
> > 
> > I hate myself for saying it, but possibly just test whether you can
> > actually build an executable that way?
> 
> I did it this way, but there were reports of Sparc platforms where the
> resulting binary should be run-tested.

Hmmm. Can I revise my original answer.... don't. If the user asks for
it, do it. Else don't.

Random behavioural changes based on the characteristics of the system we
_happen_ to build on today are probably a bad thing. Just build as
configured and don't try to auto-adapt to _anything_ :)

-- 
dwmw2

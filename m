Return-Path: <SRS0+cd78f81f0a36eea3fb57+355+infradead.org+dwmw2@baythorne.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092317787.28711.150.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1092384465.4186.37.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 09:07:45 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 15:36 +0200, Marcel Holtmann wrote:
> I looked at the patches from the bluez-utils source RPM and actually I
> can include optional PIE support for you. A simple patch for that is
> easy and actually I already did that. From what I saw, this is a GCC 3.4
> only feature and you give -pie at linking time and not at compile time
> of the sources itself. Is this correct? 

You also need -fpic in CFLAGS, I believe.

> What is the best way to detect PIE support in the compiler?

I hate myself for saying it, but possibly just test whether you can
actually build an executable that way?

> And please don't do this
> 
>         # Authentication and Encryption
> -       #auth enable;
> -       #encrypt enable;
> +       auth enable;
> +       encrypt enable;
> 
> in the bluez-utils-2.3-conf.patch. If you do that then you are going to
> set your local device in security mode 3 and this is not what you want.

Hmmm, OK.... /me refers to Google and then
http://www.niksula.cs.hut.fi/~jiitv/bluesec.html

Don't I want that? If I were to leave it out, would that leave it in
mode 1, and mean I wouldn't be required to exchange a PIN with _every_
device before I can communicate with it at all?

The gnome-bluetooth program has been known to register its OBEX file
receive service and then just dump stuff into the user's home directory
-- even files with names like .rhosts :) If I make the requested change,
would that mean that _anyone_ can exploit this, rather than only devices
with which we're already paired?

Or am I getting confused? Can we do security mode 2?

I have a _vague_ recollection that there were devices I couldn't
communicate with unless I enabled those -- but it was a long time ago
and perhaps it was just that I thought authentication and encryption
sounded like good things so I should probably enable them :)

-- 
dwmw2

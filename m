Return-Path: <x.garreau@prim-time.fr>
Message-ID: <005f01c3302e$ca3537a0$0181a8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Stephen Crane" <steve.crane@rococosoft.com>, "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
	<1054913828.26827.45.camel@pegasus>
	<1055156207.4791.301.camel@baroque.rococosoft.com>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
Date: Wed, 11 Jun 2003 17:33:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

> > kernel modules into one big package. I like to see the kernel stuff
> > seperated from the userspace tools.
>
> Yeah me too. Particularly because it's much easier to build the
> user-space tools with a cross-compiler.

Not in this release.

> I will think about doing this if I get some time. For now, I have
> uploaded the latest basic user-space binaries separately to
> ftp://rococosoft.com/pub/zaurus with instructions for installing them in
> the right places. It would not be too hard to write packaging scripts
> for them --- indeed this is something anyone could do using the
> ipkg-build script; volunteers?

I did it : http://fichiers.xgarreau.org/zaurus/bluez_2.4.18_arm.ipk

It installs the files in the right directories, make the symlinks, try to
guess what card it is and bring device up.

Please keep me informed of new builds so that i keep the package up to date.

BR
-- 
Xavier Garreau
http://www.xgarreau.org/

Return-Path: <bram@sara.nl>
Subject: Re: [Bluez-devel] [Pkg-bluetooth-maintainers] dbus dependency
	introduces unwanted X11 dependency
From: Bram Stolk <bram@sara.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        pkg-bluetooth-maintainers@lists.alioth.debian.org
In-Reply-To: <1167066856.11510.22.camel@violet>
References: <1167052771.5265.7.camel@suske>
	 <20061225165542.GA970@esaurito.net>  <1167066856.11510.22.camel@violet>
Content-Type: text/plain
Date: Mon, 25 Dec 2006 18:53:24 +0100
Message-Id: <1167069204.5265.35.camel@suske>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2006-12-25 at 18:14 +0100, Marcel Holtmann wrote:

> the bluez-utils depends on a working D-Bus system bus. It has no
> dependency on X or anything else (besides the Bluetooth library). So if
> it pulls in X related stuff then this is a fault of D-Bus or its package
> and not a problem within the bluez-utils package.

I'll take this up with the dbus maintainer then.

I still think that there is no need for X11 client stuff if you
want to run a PAN daemon. Bluetooth communication has nothing to
do with graphics devices. The 2.x version of bluez-utils demonstrated
it can do without.

  Bram

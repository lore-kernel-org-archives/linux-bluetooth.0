Return-Path: <SRS0+90beb6b14d6b6a49cdac+275+infradead.org+dwmw2@baythorne-093005.srs.infradead.org>
Subject: Re: [Bluez-devel] Bluetooth, Mobile IPv6 and PAN profile
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Wang Haiguang <wanghg@i2r.a-star.edu.sg>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085407211.9779.22.camel@pegasus>
References: <LMEOKMJFKNFFHEAEDGDEGEDNCHAA.wanghg@i2r.a-star.edu.sg>
	 <1085407211.9779.22.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085473805.27156.219.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 25 May 2004 09:30:05 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-05-24 at 16:00 +0200, Marcel Holtmann wrote:
> I've never done this nor have I tested IPv6 together with PAN, but the
> BNEP is only an ethernet emulation and so everything that's working over
> ethernet should work over BNEP, too.

IPv6 over PAN works fine for me. If you're using radvd on the access
point and you are adding each bnep%d connection to a bridge, then make
sure you poke radvd each time a device is added. When radvd starts up
there are no devices on the bridge so it seems to have MAC address
00:00:00:00:00:00. 

cf. https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=103469
and https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=104421

This is all working in Fedora Core 2.

-- 
dwmw2

Return-Path: <wanghg@i2r.a-star.edu.sg>
Date: Tue, 25 May 2004 19:18:47 +0800
From: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
Subject: RE: [Bluez-devel] Bluetooth, Mobile IPv6 and PAN profile
In-reply-to: <1085473805.27156.219.camel@imladris.demon.co.uk>
To: David Woodhouse <dwmw2@infradead.org>,
   Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-id: <LMEOKMJFKNFFHEAEDGDECEEECHAA.wanghg@i2r.a-star.edu.sg>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks.

That helps greatly.

Best regards.

Haiguang

-----Original Message-----
From: David Woodhouse [mailto:dwmw2@infradead.org]
Sent: 2004Äê5ÔÂ25ÈÕ 16:30
To: Marcel Holtmann
Cc: Wang Haiguang; BlueZ Mailing List
Subject: Re: [Bluez-devel] Bluetooth, Mobile IPv6 and PAN profile


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

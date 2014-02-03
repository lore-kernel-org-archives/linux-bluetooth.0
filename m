Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPm3yA3BzSHVG42RFp2U0m0DY5vKHVOY0gRwSOrZz8-qdsdzfQ@mail.gmail.com>
References: <CAPm3yA3BzSHVG42RFp2U0m0DY5vKHVOY0gRwSOrZz8-qdsdzfQ@mail.gmail.com>
Date: Mon, 3 Feb 2014 11:51:15 -0400
Message-ID: <CAJdJm_PCW5DQ3-qbp75F1uMryX7hoJedzE1CD-AT2tNbvwT=NA@mail.gmail.com>
Subject: Re: Working with the gatt-example.c plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sandy Chapman <schapman@lixar.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sandy,

On Mon, Feb 3, 2014 at 10:38 AM, Sandy Chapman <schapman@lixar.com> wrote:
> Hi All,
>
> I'm having some difficulties getting the gatt-example plugin working.
> I've checked out the latest tag (5.14) from git and have built it
> using the --enable-maintainer-mode configure flag so that
> gatt-example.c is compiled into a static plugin that is loaded at
> runtime. I've confirmed that the plugin is compiled and is loaded at
> runtime when I run bluetoothd.
>
> My problem is with making modifications to the plugin. I've tried
> something as simple as changing the UUID for the battery service,
> however, every time I scan the services (using an iPhone), the same
> list of UUIDs is returned (0xA002 , 0xA004, and 0xFEEE... for the
> services, which match up with what's defined in the gatt-example.c
> file). Any modifications I make to the file don't seem to have any
> effect on the services advertised. I've even rebuilt it without
> maintainer mode and have confirmed the plugin isn't loaded, but still,
> the same set of services and characteristics are loaded. Is there some
> sort of cache where the advertisement is loaded from that can be
> cleared? It looks like a bunch of HCI Commands are sent every time I
> "hciconfig hci0 up" which didn't happen when I initially ran the
> hciconfig tool prior to compiling and running bluetoothd.

Most likely iPhone is caching the attribute database and thus not
redoing any discovery. If this is the case, it is because we don't
provide a Service Changed characteristic on the GATT service,
therefore the iPhone thinks the database is static.

BTW this is a bug/limitation on the current BlueZ. While working on
the new GATT API we are also implementing a Service Changed service
that notifies changes to the entire database on every connection. This
is suboptimal (may trigger service discovery on every connection) but
at least will avoid stale cache on the client side. In future we need
to implement tracking of added / removed services and notify only
those that change.

Please use "btmon" while iphone connects to bluez and check if there
is any ATT traffic for GATT service discovery.

If this is the case, you need to find out how to clear the cache on the iPhone.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

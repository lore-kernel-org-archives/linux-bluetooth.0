Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 27 Mar 2009 21:48:41 +0100
From: "Klaus Teller" <klaus.teller@gmx.net>
In-Reply-To: <1238051121.8206.6.camel@localhost.localdomain>
Message-ID: <20090327204841.234650@gmx.net>
MIME-Version: 1.0
References: <20090327174505.23080@gmx.net>
 <1238051121.8206.6.camel@localhost.localdomain>
Subject: Re: Supporting more than 7 Connections
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I've inquired with Aircable and it appears their Bluetooth Chip can handle 7 active connections and 128 parked connections. The comment at  http://osdir.com/ml/linux.bluez.devel/2003-07/msg00110.html also suggests that the CSR chip is capable of handling more than 7 connections overall.

So, what effort would be involved in making supervisory unpark-parks in BlueZ possible?

Klaus.


-------- Original-Nachricht --------
> Datum: Thu, 26 Mar 2009 08:05:21 +0100
> Von: Marcel Holtmann <marcel@holtmann.org>
> An: Klaus Teller <klaus.teller@gmx.net>
> CC: linux-bluetooth@vger.kernel.org
> Betreff: Re: Supporting more than 7 Connections

> Hi Klaus,
> 
> > I was wondering how BlueZ handles parked connections. I came across this
> comment http://osdir.com/ml/linux.bluez.devel/2003-07/msg00110.html that
> looks like something that would allow me to transparently manage parked
> connections.
> > 
> > Essentially, the article talks about supervisory unpark-parks where
> BlueZ will could deal with parking and unparkingdevices when it has data for
> them.
> > 
> > Can somebody tell me if this has been implemented since then?
> 
> we could, but it will not help you. Almost all Bluetooth chips don't
> support more than 7 connections overall. Parked or not parked makes no
> difference. It is a memory constraint on the chip.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Neu: GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate + Telefonanschluss für nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a

Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Missing data in ACL packets from CSR chip
Date: Fri, 13 Feb 2004 10:53:48 -0800
Message-ID: <001001c3f262$b708a620$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1076694277.2671.184.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

> > It looks like a UART problem to me too, but it's probably not on my 
> > side because both the sniffer and the host saw the same error.
> 
> is it reproduceable when you use a Casira?

Unfortunately I don't have one to test with. Is the Casira the $3000
development system? I also saw just an endpoint for $700.

> > I would like to try BCSP. Are there tools available to put 
> the module 
> > in BCSP mode?
> 
> The pskey tool can do this, but at your own risc. Otherwise 
> you must write it by yourself, because I don't provide any 
> source code that is able to modify the PS.

Something I'll have to look into.

-Daryl.

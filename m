Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076331044.6869.152.camel@pegasus>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
	 <1076324203.5263.47.camel@kalkyl.roxen.com>
	 <1076325635.6869.128.camel@pegasus>
	 <1076330114.5263.85.camel@kalkyl.roxen.com>
	 <1076331044.6869.152.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076332010.5263.98.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 14:06:51 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 13.50 skrev Marcel Holtmann:
> the daemons are idle if no device is attached. So who cares?

System start is slower. Process list is cluttered. Memory is wasted.
These are the main issues.

> If they don't use Bluetooth, they don't even install it and so no
> problem. 

Can I ask you: Do you use each and every single application you
have installed on your system? :)

> Two places where we have to start a daemon? Too complex. Start it at
> init.

If the hotplug scripts somehow could talk to init, that'll work I
suppose?

Fredrik

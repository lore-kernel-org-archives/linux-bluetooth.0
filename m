Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076323138.6869.93.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076323602.5263.41.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 11:46:43 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

mån 2004-02-09 klockan 11.38 skrev Marcel Holtmann:
> I don't wanna support this. The hcid.conf file is a configuration file
> for a default configuration and don't needs to read or stored through
> the D-Bus interface. All modifications done through the D-Bus must be
> stored in another file/database. The goal is to have an interface that 
> can be used by Gnome, KDE etc. ...

This doesn't make sense. What happens when a user edits hcid.conf
manually? It's simpler and straight forward to have exactly one config
file which also can be edited manually if required. Please note that
Gnome will most likely not expose _all_ HCI configuration features and
that manual editing will be required to use these.

> The HCI is well defined in the Bluetooth specification and you can of
> course look at libs2. The source contains all defined HCI commands and
> events for Bluetoth 1.2.

OK, thanks.

Fredrik

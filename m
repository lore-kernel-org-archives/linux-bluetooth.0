Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076341569.6869.200.camel@pegasus>
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
	 <1076323602.5263.41.camel@kalkyl.roxen.com>
	 <1076324584.6869.109.camel@pegasus>
	 <1076327592.5263.64.camel@kalkyl.roxen.com>
	 <1076331669.6869.164.camel@pegasus>
	 <1076333024.5263.116.camel@kalkyl.roxen.com>
	 <1076341569.6869.200.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076342741.5263.134.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 17:05:41 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

mån 2004-02-09 klockan 16.46 skrev Marcel Holtmann:
> ask yourself what's the indentation of hcid.conf and how should a
> computer program know about it. Of course this is possible to handle,
> but it is always a mess.

hcid can have some standard indentation style but it can also support
the "--marcel-style" flag for your personal formating preferences. ;)

> No. If we use a uniform storage, there is no need for a D-Bus interface,
> because the application can modify the storage directly. 

"Plain text files" and "DBus interface" do not exclude each other. It
would be great to have them both, because they serve different pruposes:

Plain text files are great for admins, debugging, diagnostics etc.

DBus is great for system tools, Gnome, KDE etc. Besides, the DBus
interfaces provide a lot more services than just maintaining files.

> One of the main ideas is to abstract from the storage of the information.

Agreed. But storage abstraction does not implicate storage obfuscation,
does it? :)

Fredrik

Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076344242.6869.231.camel@pegasus>
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
	 <1076342741.5263.134.camel@kalkyl.roxen.com>
	 <1076344242.6869.231.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076346269.5263.162.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 18:04:29 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 17.30 skrev Marcel Holtmann:
> If a system administrator modifies some settings in complex files like
> hcid.conf, everyone uses its own identation and style to make it best
> readable for themself. And nobody likes if a program changes a value
> and introduces some odd styles.

Well, I don't agree with you on this.

Having two configuration files, where one is non-editable, with some
kind of conflict management scheme between them does not make sense, 
in my opinion. 

hcid.conf isn't too complex to handle by hcid as well as being editable
and personal formating preferences simply isn't so important that hcid
shouldn't modify this file, I think.

Besides, if you don't use the Gnome/KDE tools for hcid, the config file 
will not be modified anyway because the common DBus interfaces which use
name caches etc. have other files like the nametab/keytab files.

Fredrik

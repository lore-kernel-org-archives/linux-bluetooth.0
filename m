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
Message-Id: <1076502776.6281.81.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 13:32:56 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 11.38 skrev Marcel Holtmann:
> The goal is to have an interface that can be used by Gnome, KDE etc.
> without any proper knowledge of the running implementations and its
> configuration files. So this is not about hcid, this is about what do
> the UI applications need.

It's important for the Gnome applications to be able to do both
configuration and device management. These are two separate things.

Configuration management is about the persistent configurations
(past and present), basically those configrations stored in hcid.conf.
The Gnome applications must be able to list, add, remove and modify
such configurations. 

There may exist configurations for devices that are not attached, and 
there may also be devices attached that do not have any specific
configuration. The Gnome applications must be able to deal with these
kinds of situations intelligently.

Device management is about the devices currently attached, basically
a light version of the HCI functionality in the Bluetooth lib. The
Gnome applications should be able to list, probe and control such
devices, but probably only at a very basic/high level through DBus.

Your idea of having device managment in "org.bluetooth.hci" is good,
I think. However, we will have to decide on what that interface looks
like, because as noted in my previous e-mail, the HCI is not straight 
forward for a DBus interface. Many things are too low-level.

The configuration management is probably better suited for another
interface, possibly "org.bluetooth.conf".

Name caches, pairing etc. also have several requirements to address.
For example, requesting a pairing procedure is a typical device management
task. But managing paired devices (listing, removing etc.) is typically a 
configuration management kind of thing.

Comments?

Fredrik

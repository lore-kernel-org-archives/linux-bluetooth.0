Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] Documentation for hcid.conf ?
From: Fredrik Noring <noring@nocrew.org>
To: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1080062945.2515.26.camel@pegasus>
References: <1080053029.7507.40.camel@gryffindor>
	 <1080054257.2515.23.camel@pegasus>  <1080059454.7507.85.camel@gryffindor>
	 <1080062945.2515.26.camel@pegasus>
Content-Type: text/plain
Message-Id: <1080166993.6986.13.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 23:23:13 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Edouard

>   Otherwise, I way that someone called Fredrik Noring is also working
> on a hcid manpage, that looks fairly different from the current hcid
> distributed on the bluez homepage: is this a code branch or something?

Yes. My version of hcid (at http://noring.nocrew.org/bluetooth/) 
is extended and backwards compatible with current hcid. Important
improvements include:

  1. A hcid DBus interface for Bluetooth device management
     as well as device configuration management, key pair
     management etc.

  2. Plain text files for configuration storage. The current
     hcid for example the binary file /etc/bluetooth/link_key 
     for paired keys. This file is based on a binary dump of
     a struct and as such will be difficult to move accross
     different architectures, compilers etc. This binary file
     is automatically converted to a plain text file located 
     in /etc/bluetooth/keytab if this file does not already 
     exists.

  3. A device name cache for paried devices, making it possible
     to display the names of paired devices.

  4. Persistant storage of configurations, by saving changes in
     /etc/bluetooth/hcid.conf, managed automatically by hcid.

  5. A man page (hcid.1).

This makes it easier to write Bluetooth tools for Gnome/KDE/etc.

Fredrik

Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Phil Blundell <pb@nexus.co.uk>,
   Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077058771.2665.134.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <200402090015.24318.bluez-devel@schaettgen.de>
	 <20040216144615.GA318@nexus.co.uk> <1076945776.17824.6.camel@merlin>
	 <20040216154155.GB32285@nexus.co.uk>  <1077058771.2665.134.camel@pegasus>
Content-Type: text/plain
Message-Id: <1077206496.20897.164.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 17:01:36 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

tis 2004-02-17 klockan 23.59 skrev Marcel Holtmann:
> Any other outstanding stuff before I prepare a new release?

I have a bunch of patches that extends hcid with D-Bus interfaces
and so on (see http://noring.nocrew.org/bluetooth/) which would be 
very useful for the Gnome Bluetooth Configuration utility:

   1. The "keytab" file for link keys
   2. The "nametab" file for cached names
   3. The D-Bus interface
   4. The use of "hcid.conf" for configuration storage

Everything except (4) is implemented. 

Fredrik

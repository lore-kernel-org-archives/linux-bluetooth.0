Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Philip Blundell <pb@nexus.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077061494.2665.148.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <200402090015.24318.bluez-devel@schaettgen.de>
	 <20040216144615.GA318@nexus.co.uk> <1076945776.17824.6.camel@merlin>
	 <20040216154155.GB32285@nexus.co.uk>  <1077058771.2665.134.camel@pegasus>
	 <1077061102.685.0.camel@dixie.nexus.co.uk>
	 <1077061494.2665.148.camel@pegasus>
Content-Type: text/plain
Message-Id: <1077061750.685.3.camel@dixie.nexus.co.uk>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 23:49:10 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-02-17 at 23:44, Marcel Holtmann wrote:
> I prefer something like "org.bluetooth.pin.request".

I don't think it'd be a good idea to use "org.bluetooth", unless you can
get the bluetooth SIG to endorse the interface.  But we could certainly
use "org.bluez".

p.

Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076321200.6869.75.camel@pegasus>
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
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076322129.5263.28.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 11:22:10 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 11.06 skrev Marcel Holtmann:
> this actually depends on what you provide. The httpd provides the
> implementation of the HTTP. We will provide a general and extend
> interface to the HCI functions, so we call it "hci". The hcid is the
> implementation of these functions on the server side.

For example saving/loading the hcid configuration file (hcid.conf) isn't 
about HCI functions, is it? To include such out-of-HCI-scope functions, 
hcid should probably export interfaces beyond the HCI space:

   org.bluetooth.hci, org.bluez.hci or org.bluez.hcid.hci
   org.bluez.hcid.conf
   org.bluez.hcid.fuzz
   org.bluez.hcid.*

Can I ask you to provide a list of all the standard HCI functions? Is
the syntax/parameters/semantics defined so that exactly one HCI interface
implementation makes sense?

Many thanks,
Fredrik

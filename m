Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076287085.6869.70.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1076311376.14742.202.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 08:22:56 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-02-09 at 01:38, Marcel Holtmann wrote:
> not this way. I want to seperate the running services/profiles. The hcid
> must serve "org.bluetooth.hci" as its base.

What would the Apache webserver use? "org.w3c.http"? Something like
"org.apache.httpd" fits better for a DBus interface. Similarly hcid
ought to use "org.bluez.hcid", I think.

Fredrik

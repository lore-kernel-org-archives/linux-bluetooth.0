Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076542568.3041.45.camel@pegasus>
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
	 <1076502776.6281.81.camel@kalkyl.roxen.com>
	 <1076506129.2777.83.camel@pegasus>
	 <1076510103.6281.162.camel@kalkyl.roxen.com>
	 <1076519103.2696.58.camel@pegasus>
	 <1076538332.31726.29.camel@akka.yeti.nocrew.org>
	 <1076539335.3041.28.camel@pegasus>
	 <1076540221.31726.39.camel@akka.yeti.nocrew.org>
	 <1076541281.3041.38.camel@pegasus>
	 <1076542183.31726.44.camel@akka.yeti.nocrew.org>
	 <1076542568.3041.45.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076542884.31726.50.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Thu, 12 Feb 2004 00:41:24 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

On Thu, 2004-02-12 at 00:36, Marcel Holtmann wrote:
> No, we can store manufacturer, version, features etc. along with all
> other device information. It is very easy to keep track of these. The
> only difference with such informations is that they are read-only.

I see. Yes, that would be better. When the device is reattached, this
info may need to be updated in case something has changed though. But
it's great to have it available "off-line" as read-only device metadata.

Fredrik

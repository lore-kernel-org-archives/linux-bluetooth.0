Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076517913.2696.39.camel@pegasus>
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
	 <1076493798.6281.19.camel@kalkyl.roxen.com>
	 <1076506369.2777.88.camel@pegasus>
	 <1076508315.6281.131.camel@kalkyl.roxen.com>
	 <1076517913.2696.39.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076536853.31726.3.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 23:00:53 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

On Wed, 2004-02-11 at 17:45, Marcel Holtmann wrote:
> do we really need to store configurations based on the device id? I
> think we should store them all based on the device address only.

My opinion is that we can drop support for the "device hci0 { ... }"
syntax since it's a bit confusing - Bluetooth devices are very address
oriented so "device { ... }" and "device 00:00:00:00:00:00 { ... }"
are enough. This would also simplify the configuration code in hcid,
i.e. less risk for bugs.

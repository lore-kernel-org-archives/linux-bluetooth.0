Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] Device specific configuration
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075834077.13285.108.camel@pegasus>
References: <1075827176.13285.82.camel@pegasus>
	 <1075829711.25472.22.camel@kalkyl.roxen.com>
	 <1075834077.13285.108.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075835938.2640.15.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 20:18:58 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

tis 2004-02-03 klockan 19.47 skrev Marcel Holtmann:
> please don't include stuff that I haven't yet applied. The device
> specific configuration will be applied, but I haven't decided on
> anything else. 

The draft was indended for the development version. Btw., I've made 
my patches available at: http://noring.nocrew.org/bluetooth/

> BTW did my patch work fine for you?

Yes, I suppose you mainly changed indentation.

> What patch brings in "device default {..."? We don't need it, because we
> can use "device {..." for it.

It wasn't the same thing. "device { ... }" is the fallback device.
"device default { ... }" was intended to set default parameters for all
other device sections unless specified explicitly in those. But we can
make that the same thing of course.

> The mailing list is still "bluez-devel@lists.sf.net" and I don't tend to
> change it, because the spam stuff of SF is doing a good job.

Sorry, that was a spelling mistake.

Fredrik

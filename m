Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device specific configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075835938.2640.15.camel@akka.yeti.nocrew.org>
References: <1075827176.13285.82.camel@pegasus>
	 <1075829711.25472.22.camel@kalkyl.roxen.com>
	 <1075834077.13285.108.camel@pegasus>
	 <1075835938.2640.15.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075852509.13285.139.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 04 Feb 2004 00:55:09 +0100

Hi Fredrik,

> > BTW did my patch work fine for you?
> 
> Yes, I suppose you mainly changed indentation.

I also changed some other stuff, because I found it too complex. I need
some reports that this patch is working fine and not breaking the normal
expected behaviour.

> > What patch brings in "device default {..."? We don't need it, because we
> > can use "device {..." for it.
> 
> It wasn't the same thing. "device { ... }" is the fallback device.
> "device default { ... }" was intended to set default parameters for all
> other device sections unless specified explicitly in those. But we can
> make that the same thing of course.

We need only one of them which is default and the <hciX> or <bdaddr> can
extend these default settings. Everything else is overload.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM bug?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andy Ross <andy@plausible.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4032B8FB.8050309@plausible.org>
References: <40329CA6.7080302@mdolabs.com>
	 <1077060827.2665.137.camel@pegasus>  <4032AA5C.3060505@plausible.org>
	 <1077062902.2665.158.camel@pegasus>  <4032B8FB.8050309@plausible.org>
Content-Type: text/plain
Message-Id: <1077086937.2665.172.camel@pegasus>
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
Date: Wed, 18 Feb 2004 07:48:57 +0100

Hi Andy,

> I don't follow.  The initialization state for a tty device is
> obviously set by the kernel, not an application.  I'm simply saying
> that the kernel should initialize rfcomm devices to a state that
> matches RS232 devices, since that is what the user expects.
> 
> It's just a principle of least surprise argument.  I mean, the rfcomm module
> *could* do anything by default.  But some choices make more sense than
> others.

the RFCOMM module inits the TTY the same as the serial driver does. You
can compare it by yourself. Look at drivers/serial/serial_core.c and at
net/bluetooth/rfcomm/tty.c and you will see that the init is the same.

If I missed anything I am happy to change it.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AE3871.1000608@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco2
References: <200412010839.06669.mailsp@sebastian-eichner.de>	 <200412010943.33419.mail@sebastian-eichner.de>	 <1101894192.18840.44.camel@pegasus>	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org> <1101902920.18840.79.camel@pegasus> <41ADD32D.2060502@suche.org> <41AE065F.9040601@xmission.com> <41AE281E.3050908@suche.org>
In-Reply-To: <41AE281E.3050908@suche.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 01 Dec 2004 14:32:33 -0700

Thomas

> Currently there is no support for multiple headset because of missing 
> arguments. It was an open question how it should be done.

to actually answer the question, this looks best:

- ./btsco2 <mac1> -1 <mac2> 1 <mac3> 2
Where -1 in the Channel Parameter stand for Autodetec

because I'm not sure the autodetect will always work. Can we use '0' 
instead of '-1' for autodetect though? -1 looks like a flag.

> This would make it to what it is an small deamon with no dependecies out 
> of the kernel. This is ideal for embeded system.

If we combine the a2dp and sco support, then we need to use 
alsa-lib/aserver because it requires userspace audio processing.

If you want a voip application to work seamlessly with the headset, to 
make the headset ring on an incoming call for example, we need some kind 
of signaling like dbus.

We can continue to maintain a daemon that does not support these 
features and works well for embeded systems. What applications will you 
use the headset with and how will they start/stop/detect connections?

>>> c) Is there any Plan to allow th BT-SCO Sound driver in kernel Space 
>>> to handle mor than one bluetooth as sound device.
>>> Nice would be an option to tell the driver how many sound device he 
>>> sould allocate.

> If  there is an support i will build it in.

the kernel needs changes in bluez.

Marcel explained it once: "To get more than one SCO channel working the 
hci_usb driver must be fixed to dynamicaly change the alternate settting."

again, I don't know SCO well enough to understand this, but it sounds 
fundamental.

the btsco in the kernel also needs to be changed to allow for multiple 
simultaneous audio streams.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

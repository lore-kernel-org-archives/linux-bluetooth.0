Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092312127.15466.211.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
	 <1092311388.28711.117.camel@pegasus>
	 <1092312127.15466.211.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092313749.28711.129.camel@pegasus>
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
Date: Thu, 12 Aug 2004 14:29:09 +0200

Hi David,

> > The loading of the firmware for the 3Com PCMCIA card and the BlueFRITZ!
> > USB dongle are done through request_firmware(). The Broadcom based
> > dongles are an exception. I personal prefer to use the bcm203x kernel
> > driver for loading the firmware, but this is a 2.6 only feature.
> 
> 2.6-only is _fine_. Isn't 2.4 dead yet? I'll make sure we build the
> bcm203x driver and just drop bluez-bluefw.

I don't know if 2.4 is dead, but I think for Fedora Core it makes sense
only to package up bluez-firmware and don't compile and install bcm203x
tool from bluez-utils. Actually this is what SuSE did.

> > The bluez-firmware package only contains the Broadcom firmware files and
> > it will install them by default under /lib/firmware. You need a modified
> > firmware.agent script that also looks for firmware files in that place.
> > We agreed on that path, but this change is not upstream at the moment.
> > Check the Debian packages for an example of a modified script.
> 
> The standard place to put firmware files is /usr/lib/hotplug/firmware
> isn't it? Is there a reason for using a different path? Can you
> elaborate on the meaning of 'We' in the above context?

The problem with that path was if you need the firmware before /usr is
mounted and so we decided to use /lib/firmware.

This is the thread about it on the linux-hotplug mailing list:

http://sourceforge.net/mailarchive/message.php?msg_id=8064672

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

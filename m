Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] usb-ohci
From: Marcel Holtmann <marcel@holtmann.org>
To: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6385e5f7e2.5f7e26385e@estudiants.urv.es>
References: <6385e5f7e2.5f7e26385e@estudiants.urv.es>
Content-Type: text/plain
Message-Id: <1080042940.26745.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Mar 2004 12:55:40 +0100

Hi Albert,

> The output in lspci says that on my motherboard
> there is usb-ohci,but the thing is that I don't know
> if the host controller can be the cause why my
> device doesn't seem to be plugged in when doing
> hciconfig.
> 
> So, if my motherboard has usb-ohci, I wouldn't be
> able to load usb-uhci, but I don't know if my
> usb-bluetooth can just work with usb-uhci or if it
> should work with usb-ohci.

what you are saying makes no sense. Send us the output of lspci, lsusb,
lsmod and dmesg so we know what's really on your motherboard.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

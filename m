Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041206225609.GA1177@zeus.galaxy.org.uk>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
Content-Type: text/plain
Message-Id: <1102406244.8447.19.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 07 Dec 2004 08:57:23 +0100

Hi Chris,

> I can't get snd-bt-sco (bluetooth-alsa) to work and was told this
> was the best place to ask for help:
> 
> The problem is, btsco starts up successfully, the device indicates a
> connection has been made, but no audio can be read or written, and after
> maybe a minute the device indicates the connection has been dropped.
> There is no noticeable difference on the host side at this point, i.e.
> audio apps directed at the headset still just hang, and btsco is still
> there. The mixer produces output from btsco, but has no effect on the
> device.
> 
> Driver version: bluetooth-alsa CVS checked out 02/12/2004
> Kernel: 2.6.9 debian (presence / absence of hci_usb patch seems to make
> no difference)

why don't you try 2.6.9-mh5 or 2.6.10-rc3 ?

> Host bluetooth adapter: Trust BT180 USB
> http://www.trust.com/home/default.htm?viewpage=service/sss/preview.htm%3Fartnr%3D13853
> Headset: Logitech Mobile Bluetooth Headset
> http://www.thinkgeek.com/computing/speakers/headsets/65ff/
> Also tested: Nokia 6310i, various channels (this functionality works
> under windows)

what is the output of "hciconfig -a" and "hcitool info ..." for these
devices. And include "/proc/bus/usb/devices".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

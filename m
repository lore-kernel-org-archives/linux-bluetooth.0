Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach killed
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB79190470938E6@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB79190470938E6@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1078320753.2787.63.camel@pegasus>
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
Date: Wed, 03 Mar 2004 14:32:33 +0100

Hi Matthias,

> I run Bluez (PAN) on an arm processor device with a kernel with all
> bluez drivers built-in.
> I can perfectly PAN (ping, ftp, etc.) with other devices.
>  
> The problem is now, when I stop any program  (l2ping, ping or higher
> application e.g. upnp)
> with <Ctrl-C>,  the BT chip is always detached :
> "hciconfig" shows only 00:00:00:00:00:00 MAC-adress
> I have to hciattach again.
> If I stop programs regular, e.g. ftp with "quit", then it is NOT
> detached, only
> Crtl-C causes the problem.
> (I also observed similar "automatic detach" when devices (e.g. a
> Zaurus) go into power save 
> mode, but I think this is due to a voltage drop at the BT chip, which
> Ctrl-C shouldnt
> cause.)
>  
> I didnt experience this on arm processor devices, where the bluez
> modules (l2cap,
> hci_uart, bnep) havent been built in, so my only idea at the moment
> is, that the
> problem is due to the fact, that all is built-in. Can it be, that
> killing a program 
> with Ctrl-C kills also a socket / port / whatever  used by the
> build-in-hciattach. 

the strange thing is that if hciattach is killed, the Bluetooth device
must disappear and hciconfig couldn't show it anymore. Check in detail
what is going on there. And btw the hciattach uses the TTY ldisc of the
hci_uart driver to attach the serial port.

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

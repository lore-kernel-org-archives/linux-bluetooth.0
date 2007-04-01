Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200703312310.56438.andersin@freenet.de>
References: <200703302317.37908.andersin@freenet.de>
	<1175348178.5815.244.camel@violet>
	<200703312310.56438.andersin@freenet.de>
Date: Sun, 01 Apr 2007 09:05:49 +0200
Message-Id: <1175411149.23136.69.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Logitech diNovo Desktop: keyboard keys
	and	Mouse	buttons
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Christoph,

> > > [Logitech diNovo Keyboard does not report Fn+F11, Fn+F12 and Refresh to
> > > xev, the mouse does not report all buttons]
> 
> > when you call hidd and it shows boot-protocol, then this is no wonder.
> > You need a Linux kernel with HID report mode enabled HIDP module. You
> > might wanna try the latest 2.6.21-rc5 kernel.
> 
> Currently I am running 2.6.20 (with Ubuntu patches) with the mh1 patch applied 
> to it. I am not sure, if the keyboard is in boot-protocol mode. The syslog 
> message is:
> 
> hidd[3632]: New HID device 00:07:61:3C:31:3C (Logitech Bluetooth Keyboard),
> 
> hidd reports:
> 00:07:61:3C:31:3C Logitech Bluetooth Keyboard [046d:b307] connected
> 
> Since my original email, I have figured out that the mouse problem is mainly 
> due to using the /dev/input/mice interface, however, even when switching to 
> evdev, the buttons above and below my scroll wheel do report the same button 
> press (button 4 and 5 respectively).
> 
> I have attached dumps made with hcidump of the traffic of all my mouse buttons 
> and of the keys that are not working in the hope that this information is 
> useful.

the binary dumps are not really useful. Make them with "hcidump -X -V"
and copy only the text into an email with comments.

However it looks like you are using the HID report mode and so any non
interpreted key code is a problem of the HID subsystem. This means that
this email actually should be send to LKML. To make sense out of it you
have to include the HID descriptor. Use sdptool to get it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

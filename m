Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
To: jungle@saphire.dk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090765201.983.13.camel@aquarius>
References: <1090765201.983.13.camel@aquarius>
Content-Type: text/plain
Message-Id: <1090767190.4791.95.camel@pegasus>
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
Date: Sun, 25 Jul 2004 16:53:11 +0200

Hi Kim,

> I just bought a Logitech MX900 set (Mouse, Keyboard and Bluetooth HUB),
> and I am trying very hard to get it working. 
> 
> At the moment I am able to use the keyboard, due to the PS2 compability
> feature, but I am unable to even use hciscan to obtain a bluetooth
> address on the mouse. The only response I get from the mouse in X is up
> and down movement, laggy and unusable.
> 
> I have read the mailing list archive and the Logitech MX900 Bluetooth
> Optical mouse page (http://www.bueche.ch/comp/mx900/mx900.html) and
> followed the instructions, but with no luck. I also tried all the tips
> in the feedback section on that page. Google provided me with some
> resources which I have tried, again with no luck.
> 
> 
> At the moment I am running a 2.6.7 kernel with the 2.6.8-rc2 patch,
> which was recommended on the Bluez website. I am using Debian Unstable
> and have installed the userland utilies.
> 
> I have tried to load all sorts of bluetooth modules and compiling them
> directly into the kernel (shouldnt matter, but you know, you get
> paranoid). 
> 
> No matter what I do, I cannot get hcitool scan to give me anything but:
> 
> Device is not available: Success
> 
> hid2hci tells me:
> Switching device 046d:c703 to HCI mode failed (No such file or
> directory)

I assume that you don't have the hiddev devices nodes that are needed
for this utility. You must create them by hand, because udev is not
capable of that at the moment.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

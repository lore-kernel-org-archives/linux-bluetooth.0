Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple BT connection problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: mathias@mammoth.se
In-Reply-To: <200501130131.07302.mathias@mammoth.se>
References: <200501130131.07302.mathias@mammoth.se>
Content-Type: text/plain
Message-Id: <1105532015.7961.49.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 Jan 2005 13:13:35 +0100

Hi Mathias,

> I've searched the archive but didn't really hit the spot
> there... ...so I guess I need some help.
> 
> I'm running SuSE9.2 and trying to connect a Apple BT keyboard and
> mouse, this what's happends:
> 
> 1, If I reset the mouse and keyboard and do a server side connect it
> works just fine. After I changed to "lm master" in hcid.conf I also
> could reconnect after a sleep without a problem, so far so good, see
> the output.
> 
> "keyboard reset (off/on)"
> 
> # hidd --connect 00:0A:95:3B:1B:6E
> 
> New HID device 00:0A:95:3B:1B:6E (Apple Wireless Keyboard)
> 
> Jan 12 22:30:57 linux kernel: evdev_connect: evdev cddd3b40 handle
> cddd3b5c name event3
> 
> # hcitool con
> 
> Connections:
> 
> lt; ACL 00:0A:95:3B:1B:6E handle 41 state 1 lm MASTER
> 
> hidd --show
> 
> 00:0A:95:3B:1B:6E HID Boot Device [05ac:0209] connected
> [boot-protocol]
> 
> 2, Now, if I reboot or some how looses the connection and then
> initiate the connection from the keyboard or mouse the following
> happends:
> 
> Keaboard reset (on/off)
> 
> (tap keaboard)
> 
> # hcitool con
> 
> Connections:
> 
> > ACL 00:0A:95:3B:1B:6E handle 42 state 1 lm MASTER
> 
> # hidd --show
> 
> <nothing>
> 
> output from messages
> 
> Jan 12 22:29:10 linux hidd[7815]: New HID device 00:0A:95:3B:1B:6E
> (Apple Wireless Keyboard)
> 
> Jan 12 22:29:10 linux hidd[7815]: HID create error 25 (Inappropriate
> ioctl for device)

we saw that problem and it only occurs when you configured another input
device through YaST. It is unclear what triggers this problem. Using a
vanilla kernel I wasn't able to reproduce it. What other input devices
are in your machine?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

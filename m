Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Keyboard & mouse operate in boot protocol mode
	causing extra keyboard events with 2.6.10-mh1 and bluez-libs/utils 2.13
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1105049361.6048.9.camel@pc.vesuri.net>
References: <1105049361.6048.9.camel@pc.vesuri.net>
Content-Type: text/plain
Message-Id: <1105050548.4299.95.camel@pegasus>
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
Date: Thu, 06 Jan 2005 23:29:08 +0100

Hi Vesa,

> a couple of months back I had a problem with extraneous keyboard events;
> when I typed "sources" I got "sourceces" and so on. This was fixed by
> applying an -mh kernel patch that had HID report protocol mode support.
> 2.6.9-mh3 and bluez-libs/utils 2.10 worked fine but now I upgraded to
> 2.6.10-mh1 and bluez-libs/utils 2.13 and this problem is back again.
> 
> hidd --list gives me
> 
> 00:07:61:19:9E:A9 HID Boot Device [046d:b301] connected [boot-protocol]
> 00:07:61:19:FA:68 HID Boot Device [046d:b001] connected [boot-protocol]
> 
> so it seems it's not using the HID report protocol but the boot
> protocol. hidd --list also used to show the correct names of the devices
> (Logitech MX900 Mouse etc.) instead of just HID Boot Device.
> 
> What can I do to make hidd use the HID report protocol mode (or whatever
> is necessary to fix this problem)?

go back to 2.6.9-mh3 or wait until the HID report protocol support is
back in the -mh patch. I removed it for the final transition into a
generic HID parser.

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

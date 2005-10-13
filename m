Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help with Digianswer protocol analyzer
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <001901c5cfe1$29a64180$6701a8c0@mainframe>
References: <001901c5cfe1$29a64180$6701a8c0@mainframe>
Content-Type: text/plain
Message-Id: <1129201609.6951.1.camel@localhost.localdomain>
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
Date: Thu, 13 Oct 2005 13:06:49 +0200

Hi Jonathan,

> I have a digianswer protocol analyzer connected to my computer via
> usb.
> Problem is I can't seem to get it up running.
>  
> hciconfig -a , produces the following
>  
> hci0:    Type: USB
>             BD Address: 00:00:00:00:00:00 ACL MTU: 0 :0 SCO MTU: 0:0
>             DOWN
>  
> hciconfig hci0 up
>  
> Can't init device hci0: Commection timed out (110)
>  
> I am currently slackware 2.6.11.8, with bluez-libs 2.21 installed.
>  
> lsmod displays the following
>  
> hci_usb            14344    0
> bluetooth          43268    1    hci_usb
>  
>  
> I'm guessing it detects the device but I havent got the right driver
> loaded?

show me the content of /proc/bus/usb/devices and check if you have the
bpa10x kernel driver. If not then you might need to install a newer
kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

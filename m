Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Limitation of emulator ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Varat Chaikasetsin <varat_c@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20040210T083307-660@post.gmane.org>
References: <loom.20040210T083307-660@post.gmane.org>
Content-Type: text/plain
Message-Id: <1076401392.32750.9.camel@pegasus>
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
Date: Tue, 10 Feb 2004 09:23:12 +0100

Hi Varat,

>    I'm doing  my final year project about routing in Scatternet.I need to have 
> lots of BT devices for this project so I decided to use "hciemu" to simulate 
> many BT devices instead of using the real ones.
>    Everthing seems to be allright with that emulator but now I'm facing a big 
> problem. I can't simulate BT device more than 15 devices (hci0 - hci15).I  
> use "hciemu localhost:xx" command to simulated all devices. 
>    Moreover, when I've simulated 15 devices then pluged the USB device in ,I 
> can't see or use that USB device by using "hciconfig" command.
>     What am I doing wrong? what should I do ? or it's a limitation of the 
> emulator ?

the kernel side has no limit of attached devices, but the userspace
tools like hciconfig etc. are limited to maximal 16 devices.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

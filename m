Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] detecting BT devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b895079705010722156869ddd7@mail.gmail.com>
References: <b895079705010722156869ddd7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105193038.8137.3.camel@pegasus>
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
Date: Sat, 08 Jan 2005 15:03:58 +0100

Hi Weston,

> I am aware of scanning for bluetooth devices, but is there anyway I
> can have my linux box notify me when bt devices come in range? Or
> something along those lines?

you can use the HCI raw socket in together with the periodic inquiry
feature. However you must write a program for this by your own.

> Also, anyone got reading material for using RFCONN to interact with bt
> devices using rs232 stuff.

Check the mailing list archive and the web. There are a lot of examples
around there.

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

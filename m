Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing to devices with bluez and widcomm
	withsame adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Nosve <nosve@libero.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <AGELIJDLJNOPFNMOHHIFEECKCAAA.nosve@libero.it>
References: <AGELIJDLJNOPFNMOHHIFEECKCAAA.nosve@libero.it>
Content-Type: text/plain
Message-Id: <1074865136.3071.125.camel@pegasus>
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
Date: Fri, 23 Jan 2004 14:38:56 +0100

Hi Nosve,

> Just a thing I forgot, when I have to delete the link key for the explained
> things,
> hcid doesn't matter about it, maybe it buffers the keys only at startup,
> neither with a kill -HUP, which seems however intercepted. The only option
> is to
> restart hcid.

the new security manager will have a real database backend and will be
capable of handling such scenarios, but by now this is the only way.

> As for regards the other thread tha discuss the possibility of storing the
> link
> key in bt adapter, I understand that the possibility to do that has to be
> investigated from widcomm? Or from the manufacturer of the adapter, with
> hci arbitrary commands to send to the adapter?

You only have to store the link key once on the chip and you never have
to care about the authentication procedure again. Decide by yourself
what place is safer. The dongle or your harddisk.

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

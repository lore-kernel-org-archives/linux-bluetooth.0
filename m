Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing to devices with bluez and
	widcommwithsame adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Nosve <nosve@libero.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <AGELIJDLJNOPFNMOHHIFAECLCAAA.nosve@libero.it>
References: <AGELIJDLJNOPFNMOHHIFAECLCAAA.nosve@libero.it>
Content-Type: text/plain
Message-Id: <1074874501.3071.132.camel@pegasus>
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
Date: Fri, 23 Jan 2004 17:15:01 +0100

Hi Nosve,

> I don't want to be pedantic, but the question is how to store the link key
> in the chip, I must use hcitool to send some form of commands? Or maybe
> there are some documented possibilities which I have not found?

the support for stored link keys is not very good. You must write it by
your own. The code of the new library also have no tool for it at the
moment, but the API call is there.

> Even from the other thread I don't understand if maybe we must hope there is
> a possibility to save the link key with widcomm stack.

If the link key is stored on the chip, the host stack don't have to do
anything. All authentication stuff will be handled by the link manager.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sockets connect before accept()
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Bandouch <news.jan@jbc-computer.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <401B7892.1000704@jbc-computer.de>
References: <40193837.1070605@jbc-computer.de>
	 <401B7892.1000704@jbc-computer.de>
Content-Type: text/plain
Message-Id: <1075562028.2720.0.camel@pegasus>
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
Date: Sat, 31 Jan 2004 16:13:48 +0100

Hi Jan,

> I've finally figured out how to establish the connection correctly via 
> select(..). Was my error in interpreting the return code.
> The main problem seems to be on the Palm side, because it gets the
> connection established event, even if it isn't really established (but 
> somehow pending), cause I didn't yet accept it on the server side. This 
> is strange behavior in my opinion, but well, thats how it seems to be.
> 
> But I would still be interested in someone who can tell me what's the 
> exact information that "cat /proc/bluetooth/rfcomm" gives me. Or a hint 
> where to find this information.

look at rctest for an example or show us your code.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Lintner <John281198@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1324.1093866265@www49.gmx.net>
References: <1324.1093866265@www49.gmx.net>
Content-Type: text/plain
Message-Id: <1093867195.5620.16.camel@pegasus>
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
Date: Mon, 30 Aug 2004 13:59:55 +0200

Hi Johannes,

> The way, to start a server on the Handy I already tried, but I didn't had in
> mind, that this has to be so, but to have a completely new connenction
> between the devices (or has it to be so?).

forget about that. I was confused and thought that you wanna connect
from the PC to your phone,

> The complete protocol is attached to the mail. The accosted lines exists
> (see attachment - would it be better to see the java-sources?).

If you put it into a tar then name it this way ;)

> On the pc runs a server, that is listening to a connection. A mobile phone
> searches for the device and the service, tries to connect an sends a 7byte
> long string ("String!"). This way works without any problems. Immediately
> after receiving, the server sends an 6byte long string("Handy!") to the
> phone, using the same connection. But the phone only receives an empty
> string.

The string "Handy!" goes over the connection and right after that the
Linux side closes the connection. Maybe that is the problem or it is the
credit based flow control on the phone. I don't see any CFC problem, but
I also didn't wrote the Bluetooth stack on the phone. I think it is a
good idea to add a sleep(1) before you close the connection.

Some other information might be handy. What kernel do you use and what
do you use as server on the Linux side? What kind of phone is this?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Bluethooth "Elite" Keyboard & Mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501161851.01291.cijoml@volny.cz>
References: <20050116174616.GA2201@virgilio.it>
	 <200501161851.01291.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1105898506.8080.20.camel@pegasus>
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
Date: Sun, 16 Jan 2005 19:01:46 +0100

Hi Michal,

> You should use 2.6.10-mh1 and latest firmware for Digianswer dongle (adapter 
> use it I think)

using the 2.6.10-mh1 is a good idea, but it is a Broadcom dongle with
HID proxy and this don't need any extra firmware. However since the
other Broadcom HID proxy that I have does the switch into HCI mode when
you send a HCI_Reset (CSR HID Proxy needs an extra tool btw), the one
from Microsoft may need some extra magic to fully work without problems.
I need someone to donate one of these, because there is no way to buy
only the dongle and I am not going to buy another Bluetooth keyboard. I
have enough.

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

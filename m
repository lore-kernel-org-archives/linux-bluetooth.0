Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Serial connection between two Linux machines
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas.Luby@nokia.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <37AD475D23C5D0469726DD437E59714151177E@esebe022.ntc.nokia.com>
References: <37AD475D23C5D0469726DD437E59714151177E@esebe022.ntc.nokia.com>
Content-Type: text/plain
Message-Id: <1090479270.21828.20.camel@pegasus>
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
Date: Thu, 22 Jul 2004 08:54:30 +0200

Hi Thomas,

> Sorry to trouble you again.
> 
> Quite simply, the connection remains open until I send something over the serial port. Then it closes
> 
> There must be some character that causes this like eof
> 
> Is this normal? Has you experienced this behaviour before?

this can be possible, but I've never seen it so far. Setting the RFCOMM
TTY into raw mode before using it is maybe a good idea. Otherwise you
should check with strace and hcidump what is really going on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Serial connection between two Linux machines
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas.Luby@nokia.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <37AD475D23C5D0469726DD437E5971412D0D25@esebe022.ntc.nokia.com>
References: <37AD475D23C5D0469726DD437E5971412D0D25@esebe022.ntc.nokia.com>
Content-Type: text/plain
Message-Id: <1090428620.21683.126.camel@pegasus>
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
Date: Wed, 21 Jul 2004 18:50:20 +0200

Hi Thomas,

> I have tried "rfconn connect" instead but get the same results. 
> 
> If I keep the connection open it works (using cat as you suggested) however this doesnt work if I make a getty port on the slave side
> 
> I think the problem is on the slave side because if I connect the slave to Windows then I get the same issue. The Windows terminal disconnects after 1 "echo" or one file cat
> 
> Is there a command I can use on the slave side that keeps the port open once connected (this is what I tried with dund --persist)
> 
> Are the commands OK on the slave side?

there is no easy command to bind a listen RFCOMM channel to a TTY. You
must write your own program that does this the same way as dund does it.

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

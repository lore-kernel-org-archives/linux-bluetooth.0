Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] obexserver and t68i problem?
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407251438.08135.cijoml@volny.cz>
References: <200407251403.50608.cijoml@volny.cz>
	 <1090758097.4791.81.camel@pegasus>  <200407251438.08135.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1090759756.4791.87.camel@pegasus>
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
Date: Sun, 25 Jul 2004 14:49:16 +0200

Hi Michal,

> it shouldn't be...
> lp hold,sniff,park,rswitch;
> 
> CSR 16.1.1

it is the Microsoft dongle and this is not HCI 16.4 even if it includes
many fixes that weren't in the HCI 16.1 firmware.

> MS mouse and keyboard connected

This is maybe the problem, because your PC is the master of a piconet
with two slaves and you are trying to connect from another master (your
mobile phone) into it. What kind of phone is it?

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

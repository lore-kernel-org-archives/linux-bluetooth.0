Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unknown HCI packet type / 3CRWB6096B
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Sykora <Jan.Sykora@fel.cvut.cz>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <40F65E84.3020104@fel.cvut.cz>
References: <40F3BD15.30908@fel.cvut.cz> <1089826519.4517.7.camel@pegasus>
	 <40F65E84.3020104@fel.cvut.cz>
Content-Type: text/plain
Message-Id: <1089888965.3569.24.camel@notepaq>
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
Date: Thu, 15 Jul 2004 12:56:05 +0200

Hi Jan,

> Unfortunately it did not help. I have now
> 
> kppp with CRTSCTS flow control and
> 
> hciattach /dev/ttyS17 any 115200 flow
> 
> and I am getting the same error messages.
> 
> Do you have any other hints? Thanks.

the best would to switch the CSR chip into BCSP mode and us this. I
don't own the version 3.0 of that card, so I can't do any tests.

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

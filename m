Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050225082547.84269.qmail@web26603.mail.ukl.yahoo.com>
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Re: [Bluez-users] trying to send data at HCI level
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1109068760.8506.13.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Fri, 25 Feb 2005 09:25:47 +0100 (CET)

Hi,

I was trying to send HCI command i define all the
debug tools of buetooth.ko.
Therfore I create AF_Bluetooth socket family.
My data isn't received by my dongle.

for debuging I was searching for the command read()
from socket in the hci_sock.c side.
But I didn't find it. 
I think that it's hci_sock_sendmsg() wich forward my
HCI command to hci_usb.ko.

but how bluetooth.ko layer catch my HCI command?

regards 
benny






	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Surfkid19 Surfkid19 <surf-kid20@freemail.hu>
To: bluez-users@lists.sourceforge.net
Message-ID: <freemail.20050224201238.65123@fm1.freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Subject: [Bluez-users] receiving files from the phone
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
Date: Thu, 24 Mar 2005 20:12:38 +0100 (CET)

Hi,

I'd like to transfer files from a nokia phone to the PC. How
can I achieve this?
What are the transfer rates you've experienced?

What I've already tried:

linux 2.4.28 + affix bluetooth driver + btctl utility's OBEX
FTP commands:
it works, but only with 13-15kbyte/sec receiving speed

liunx 2.6.10 + the kernels inbuilt bluez driver and the
following programs:

btftp from the bluez CVS (receiving speed about 25kbyte/sec)
KDE's bluetooth utilities which have an obex FTP transfer
utility it could receive
at a rate of 20kbyte/sec.

My question is how to debug what makes transfer so slow?
What rates have you exprienced using obex ftp and object
push? (I'm particularly interested in the phone>PC direction).
Any other possibilities for file transfer apart from obex
ftp and object push?

I'd appreciate any help!

Best Regards,
Surfkid

PS: the dongle I've used at the PC is a cambridge type USB
dongle, with the standard hci_usb driver. 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

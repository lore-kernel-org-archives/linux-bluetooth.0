Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Reply-To: <ag@new-media-artists.de>
From: "Andreas Gaufer" <ag@new-media-artists.de>
To: "Bluez Devel" <bluez-devel@lists.sourceforge.net>
Message-ID: <FJENILNPNAGPJMMDOKDCAEOCDLAA.ag@new-media-artists.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] Master, Slave and Maximal Peers Questions
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Jan 2004 07:13:30 +0100

Hi Marcel,

>> connecting many devices you should also be aware that IMHO one
USB-BT-Chip
>> can only handle 2 outgoing master connections.

>this is wrong. A device can be master of 7 active slaves and of course a
>master can be slave in another piconet. You can't have a master in two
>different piconets.

Hm, so i got this wrong. But if i connect two different devices with rfcomm,
"hcitool con" gives me two lines that look like
"< ACL 00:0A:D9:37:11:29 handle 41 state 1 lm MASTER". Thats what i meant
talking about "master connections". If i start another rfcomm connect (the
third one)i get "Device or resource busy" and i assumed thats because the
chip i use (CSR, hci rev 16.4) can only handle two master connections. I
found this info, that a 16.x CSR can make 7 Connections, while 2 of them can
be Master on some web page that i remember to be on your server,
unfortunatelly i cant find it anymore.

Im just wondering what a line ending with MASTER from hcitool con actualy
means. IMHO it should mean that this is a peer is a slave in a piconet with
me as the master. But why does rfcomm than say that "Device or resource
busy" when i try to connect a third slave witch should be possible?

Greetings

Andy



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

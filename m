Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408021859.44496.harbaum@beecon.de>
Subject: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
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
Date: Mon, 2 Aug 2004 18:59:44 +0200

Hi,

i have been using bluez l2cap for quite some time now. To my BlueMP3 receiver 
i have streamed gigabytes via l2cap with no problems using bluez as a sender 
so far.

A customer of mine now told me, that l2cap under bluez is unrealible. It was 
hard to believe, but the follwing archive contains to little programs i wrote 
to verify this. It's a sender and a (artifically slowed down) receiver:

http://www.harbaum.org/till/l2flow.tgz

The sender is marking the packets with some sequence number. After about 
80kBytes the receiver starts complaining about missing sequence numbers. 
Since i can stream to my won hardware (and successfully slowing down the 
transmission, since the receiving mp3 decoder is only taking the data at the 
appropriate bandwidth) i am sure that sending data with bluez is not the 
problem. However the receiver seems to fetch all packets from its bluetooth 
hardware and is dropping packets if it then sees, that it has run out of 
internal buffers.

Why is that? Can this be avoided? Is this by purpose?

Ciao,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

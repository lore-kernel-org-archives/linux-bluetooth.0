Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Martin MAURER <martin.maurer@email.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1063204541.14708.17.camel@z439-033-17.raab-heim.uni-linz.ac.at>
Mime-Version: 1.0
Subject: [Bluez-users] problems with epox dg02
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Sep 2003 16:35:41 +0200

Hi all,

I recently bought two Epox DG02 usb bluetooth adapters.
Connecting to my mobile phone works well,
but when I try to use pan networking (notebook to desktop computer, both
debian linux) I get an 

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection E0:C3:80:61:04:00

error when i try to transfer a lot of data via this connection after a
few seconds.

I tried the following kernel versions:
2.4.22
2.4.22-mh1
2.4.21
2.4.20
2.4.20-mh12

sometimes with zero packets, and sometimes without.
sometimes with SCO voice support, and sometimes without.

(i got the best results with 2.4.20-mh12 +zero packet -SCO voice)

any suggestions what to try next ?

anyone on this list who has such a chip working ?
which kernel version and mh version do you use,
with SCO voice ?
with zero packets ?

greetings
Martin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

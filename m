Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph Scholz <scholz@cs.uni-bonn.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1073656142.3037.32.camel@willie.informatik.uni-bonn.de>
Mime-Version: 1.0
Subject: [Bluez-users] Problems with Bridging and PAN Profile
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
Date: Fri, 09 Jan 2004 14:49:02 +0100

Hi all,

I am experiencing problems with the Linux transparent bridge
implementation combined with BlueZ. Probably it is not BlueZ' fault but
related. Just wanted to know if someone else knows about this problem.

I used a very simple PAN scenario with one master (GN) and two slaves
(PANU). The GN runs a Linux bridge and the individual devices for the
slaves are added to the bridge by using the "/etc/bluetooth/pan/dev-up"
script. All similar to the PAN Howto.

After establishing the two connections everything works fine. But after
disconnecting the first slave (the one that was connected to the master
first) communication between the master and the remaining slave does not
work any more. Closer investigation shows that the failure is found in
the bridge device that does not accept the received frames any more.
Interestingly, when runing tcpdump on the bridged device everything
seems to work fine again. This is probably due to the bridge device
entering promiscuous mode. Probably, the problem is related to the
following message found in /var/log/messages:

"bnep1: attempt to add interface with same source address."

This is due to the fact that all the bnep interfaces own the same MAC
address (= BD_ADDR of the Bluetooth device).

It seems the Linux bridge does not work reliably with duplicate mac
addresses on its interface. 

Does anyone of you experienced similar problems? Any ideas on how to
resolve this?

Thanks.


Regards,

Christoph
-- 
Christoph Scholz <scholz@cs.uni-bonn.de>
University of Bonn, Institut of Computer Science IV
Römerstraße 164,
D-53117 Bonn, Germany
Phone: +49 228 73 4117
Fax: +49 228 73 4571
http://web.informatik.uni-bonn.de/IV/Mitarbeiter/scholz/



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

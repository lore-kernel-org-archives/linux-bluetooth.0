Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Christoph Scholz <scholz@cs.uni-bonn.de>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-OK7ZlGD9z7crm9Kjnv9H"
Message-Id: <1084452714.2318.12.camel@willie.informatik.uni-bonn.de>
Mime-Version: 1.0
Subject: [Bluez-devel] PAN and bridge problem when bnep0 disconnects before bnep1
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
Date: Thu, 13 May 2004 14:51:54 +0200


--=-OK7ZlGD9z7crm9Kjnv9H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I experienced the same problem as Matthias Thomae. I already posted this
to the mailing-list some time ago (see attached mail). It is actually a
problem with the Linux bridge code. It does not seem to be able to cope
with multiple interfaces using the same MAC-Address.

Unfortunately, I have no real solution to the problem.

Regards,

Christoph

--=-OK7ZlGD9z7crm9Kjnv9H
Content-Disposition: inline
Content-Description: Forwarded message - Problems with Bridging and PAN
	Profile
Content-Type: message/rfc822

Subject: Problems with Bridging and PAN Profile
From: Christoph Scholz <scholz@cs.uni-bonn.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Organization: University of Bonn
Message-Id: <1073656142.3037.32.camel@willie.informatik.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 14:49:02 +0100
Content-Transfer-Encoding: 8bit

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

--=-OK7ZlGD9z7crm9Kjnv9H--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

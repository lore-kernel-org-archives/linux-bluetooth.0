Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Patrick Duchstein <patrick-bluez.org@prote.st>
To: bluez-users@lists.sourceforge.net
Message-Id: <20040809164445.4c304eb5.patrick-bluez.org@prote.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Bluetooth transmission rates
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
Date: Mon, 9 Aug 2004 16:44:45 +0200

Hi,

I did some timing measurements for packet round-trips between two
Bluetooth hosts comparing the different ACL packet types, resulting in
the plot located at http://www.duchstein.com/perf-packettype-kbu.eps
One side is linux with the BlueZ stack and a CSR chip, other side is my
own stack using an Ericsson ROK 101 007.

I now have some trouble interpreting these measurements, two facts I
cannot explain:
1. why is the transmission rate for packets with very small payload so
low among all packet types? Shouldn't it be equal to larger payload
sizes, as long as the packet type is the same?
2. the raise in transmission rate starting at a payload size of 192
bytes stems from fragmentation due to a limited buffer size of one of
the host controllers (CSR:192 bytes). But shouldn't it be a big step
instead of a slow increase then?

Thanks in advance for any help,
Patrick


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: Bluez-users <bluez-users@lists.sourceforge.net>
Date: Mon, 09 Jul 2007 20:52:13 +0200
Message-Id: <1184007134.5105.135.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] uClibc and bluez 3.7 or bluez 2.25
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello all experts,

I am implementing Bluez on an embedded system, and would
much appreciate comments on a strange behaviour I am 
observing. I know that most of you consider Bluez-utils 2.25
ready for oblivion, but I disagree, so please listen.

My server and bluetooth master is running Bluez-utils 3.7
and glibc 2.3.6 under kernel 2.6.18, since it is a Debian Etch system.

Now I have an embedded system using kernel 2.6.11.12-mh2, uClibc 0.28.3,
and bluez-utils-2.25 without D-bus. When issuing

# hcitool info 00:10:60:d0:01:67
Requesting information ...
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
	BD Address:    and so on

always result, with kernel code from hci_core.c always complaining
twice about unknown handle 12.

The remarkable thing is that neither of two other systems:

    A) kernel 2.6.8-mh2, glibc-2.3.2, Debian Sarge, with         
           bluez-utils-2.25 without D-bus

    B) kernel 2.6.18, glibc-2.3.6, Debian Etch, 
           bluez-utils without D-bus

causes any complaints about "ACL handle 12" whatsoever, neither
between themselves, nor against the server with bluez-utils-3.7.

Thus I am inclined to guess at a non-ideal API between uClibc,
the Bluez kernel code, and bluez-utils. Does any of you have
any related experience to contribute here? My effort to scan
the kernel code to identify the meaning of "handle" for the 
purpose of the Bluez stack has come to an end at untangeling
its cooperation with "struct sk_buff", so I could honestly
use some help.

An additional strange behaviour of that embedded system, is that
its dhclient is able to send a broadcast over bnep0 to ask for
a leased ip-address, but it is unable to capture the dhcp-offer
that comes in return from the server. Both broadcast are fully
functional when used via a standard ethernet device, say eth0.

I realize that the above is far from mainstream, but I personally
believe there could be much use of bluetooth functionality for
embedded computers, not only bluetooth enhanced gadgets.


Best regards, and many thanks for your reading diligence,

Mats E Andersson 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

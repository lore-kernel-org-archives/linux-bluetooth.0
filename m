Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ciro Scognamiglio <moray@libero.it>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problems with epox dg02
Message-ID: <20030911130058.GD4654@libero.it>
References: <1063204541.14708.17.camel@z439-033-17.raab-heim.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063204541.14708.17.camel@z439-033-17.raab-heim.uni-linz.ac.at>
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
Date: Thu, 11 Sep 2003 15:00:58 +0200

On Wed 10 Sep 03 16:35 +0200, Martin MAURER wrote:

> Connecting to my mobile phone works well,
> but when I try to use pan networking (notebook to desktop computer, both
> debian linux) I get an 
> 
> hci_acl_tx_to: hci0 ACL tx timeout
> hci_acl_tx_to: hci0 killing stalled ACL connection E0:C3:80:61:04:00
> 
> error when i try to transfer a lot of data via this connection after a
> few seconds.

This seems like my problem with the DBT-120 usb dongle I have, but:
hcidump doesn't give a clue of what is happening
and I use the serial profile to estabilish a ppp connection with the SE p800

> 
> sometimes with zero packets, and sometimes without.
> sometimes with SCO voice support, and sometimes without.

At the moment I am using the 2.4.22-mh1 and tryed enabling both
zero packets and SCO vocie. If disabled it seems to work better,
i.e. I don't have to unplug the dongle to get the connection
work again, but just kill pppd and relaunch it.

BTW, I would also like to see if it hppens also with the obex push
profile, but how? I mean, what is the best app to use to transfer
a file using BT?

ussp-push doesn't work for me...also, do I have to bind or connect an
rfcomm port to the obex push profile before trasfering files?

last ~10 rows of hcidump output before the connection dies.

If someone could help (Marcel?) I could send the whole dump as soon as I get
the connection up (it doesn't last a lot, some times just a few seconds)

> ACL data: handle 0x002a flags 0x02 dlen 34
< ACL data: handle 0x002a flags 0x02 dlen 192
< ACL data: handle 0x002a flags 0x01 dlen 67
    L2CAP(d): cid 0x42 len 255 [psm 0]
< ACL data: handle 0x002a flags 0x02 dlen 192
< ACL data: handle 0x002a flags 0x01 dlen 67
    L2CAP(d): cid 0x42 len 255 [psm 0]
< ACL data: handle 0x002a flags 0x02 dlen 192
< ACL data: handle 0x002a flags 0x01 dlen 67
    L2CAP(d): cid 0x42 len 255 [psm 0]
< ACL data: handle 0x002a flags 0x02 dlen 21
    L2CAP(d): cid 0x42 len 17 [psm 0]
> ACL data: handle 0x002a flags 0x01 dlen 40
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5

Ciro.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

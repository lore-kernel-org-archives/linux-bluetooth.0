Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-PEt4XunSXSjQVHSO9LdP"
Message-Id: <1103312469.4788.15.camel@justakiss>
Mime-Version: 1.0
Subject: [Bluez-users] GPRS /  pppd problem
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
Date: Fri, 17 Dec 2004 20:41:10 +0100


--=-PEt4XunSXSjQVHSO9LdP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm using GPRS on a Ericsson T630 over bluetooth successfully. When I
press a key on the phone to terminate the GPRS connection, pppd doesn't
recognize that, however. I did a hcidump to see what happens after the
key has been pressed on the phone (see below). Any ideas if there's a
way to signal pppd that the GPRS connection has been terminated? The
pppd debug log doesn't show any activity in that case.

Regards,
Erwin



--=-PEt4XunSXSjQVHSO9LdP
Content-Disposition: attachment; filename=dump
Content-Type: text/plain; name=dump; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 0]
      0000: 01 ef 08 00 e3 05 0b 0d  aa                       .........
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0092 len 8 [psm 0]
      0000: 03 ef 09 e1 05 0b 0d 70                           .......p
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 0]
      0000: 09 ff 01 00 5c                                    ....\
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 0]
      0000: 09 ff 0c 00 00 0d 0a 4f  4b 0d 0a 5c              .......OK..\

--=-PEt4XunSXSjQVHSO9LdP--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: "Jiri Prazak" <bohemius@volny.cz>
To: bluez-users@lists.sourceforge.net
Message-ID: <73d8c3bd2463806fbd0544eec8b00c2b@www1.mail.volny.cz>
Content-Type: text/plain; charset="iso-8859-2"
Subject: [Bluez-users] problems pairing with Nokia 3650
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
Date: Mon, 15 Sep 2003 18:58:10 +0200 (CEST)

Hello all,

I have RedHat 8, I have upgraded the kernel to version
2.4.20-19.8 and it is running on a Dell Latitude Notebook with
BlueTake BT007 bluetooth adapter.

It seems that I have somewhat succesfully installed and
configured BlueZ stack on it, hcitool can see my Nokia3650, I can
ping it, rfcomm binds it but I cannot pair the two for my life.

1.  Pairing initiated from the phone.  My phone finds
"mynotebook"  when I select New paired device, it reports
"waiting for mynotebook" and then it says "unable to pair with
mynotebook" without ever asking for pin or anything.  The hcidump
is as follows

> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0045
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0045 result 2
status 0 > HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Max Slots Change(0x1b) plen 3
> HCI Event: Disconn Complete(0x05) plen 4

I cannot make any sense out of this but I see no errors.

2. Pairing initiated from "mynotebook".  I use rfcomm connect
btaddress and the phone asks for a pin, I type in the pin
(correct one) and I get either

* connection refused

or

* Can't connect RFCOMM socket: Resource temporarily unavailable

on the terminal.  Obviously if this does not work I cannot use
gprs and pppd either.  Interesting thing is that before I try
connecting using pppd rfcomm says the channel is clean and after
the thing bombs it reports channel closed.  I really have no idea
where the problem is, I tinkered with hci.conf and such but
nothing seems to help, even disabling authentication has no
effect.  First I thought it was going to be a minor config issue
since the phone is visible but I'm not sure anymore.  Any help
and advice is appreciated.

Thanks Jirka

--=20
Vyhraj Ford Fiesta s klimatizac=ED a dal=B9=ED ceny!
V=EDce na http://soutez.volny.cz=20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

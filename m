Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203171303.65603.qmail@web26405.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] USING PAN: PANU(desktop1) ->NAP(desktop2)->internet
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107448986.11944.87.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 3 Feb 2005 18:13:03 +0100 (CET)

hi Marcel,
I read Howto about PAN and I did :
for the NAP:
# pand --listen --role NAP

for the PANU:
# pand --nodetach --role PANU --search --service NAP

pand[31712]: Bluetooth PAN daemon version 2.15
pand[31712]: Inquiring
pand[31712]: Searching for NAP on 00:02:C7:15:11:04 
"it's my NAP"

config of the NAP
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:C7:15:11:04 ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:28224 acl:459 sco:0 events:652
errors:0
        TX bytes:20479 acl:357 sco:0 commands:141
errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'imad'
        Class: 0x3e0100
        Service Classes: Networking, Rendering,
Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1
(0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)


config of the PANU
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:33:43:A5 ACL MTU: 120:20
SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:14593 acl:192 sco:0 events:330
errors:0
        TX bytes:17841 acl:262 sco:0 commands:44
errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'thomas'
        Class: 0x3e0100
        Service Classes: Networking, Rendering,
Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2
(0x2) LMP Subver:
0x757
        Manufacturer: Silicon Wave (11)


but MY PANU doesn't find the NAP service over my
NAP???
wath's the probleme can you help me?

and ohter thing wath that mean "nat" and
"masquerading"
I find that in http://quozl.netrek.org/bluetooth/

after making bnep interface between my tow dongle i
have to write :
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 
echo 1 > /proc/sys/net/ipv4/ip_forward

what does it mean?

tanks,
imad


 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi,
> 
> > I want to develope a Gatway in linux OS (kernel
> 2.6) I
> > have the bluez stack and it work very well.
> > 
> > I want to use thes PAN profile with a NAP role for
> my
> > GW and PANU for other end users.
> > 
> > End users want to access to internet via the
> Gatway
> > (AP).
> > my acces point is now just a PC with a BT-dongle.
> This
> > PC is connected to internet via a LAN.
> > 
> > and my end user is another PC with a BT-dongle.
> > 
> > I tried yesterday to connect themselves via IP
> with a
> > client server connection using aGN role for one
> and
> > PANU for the other. It works funny. 
> > 
> > So cans you give me the lines of code I have to
> write
> > in each PC.
> > if someone had already do that can you give me
> your
> > code on each side.
> 
> the PAN howto is quite helpful and the rest is about
> masquerading and
> NAT. There are enough howtos on the internet. The
> BlueZ PAN provides you
> with a virtual network card and it works the same as
> any network card in
> your machine.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW --
> Interactive Reporting
> Tool for open source databases. Create drag-&-drop
> reports. Save time
> by over 75%! Publish reports on the web. Export to
> DOC, XLS, RTF, etc.
> Download a FREE copy at
> http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Han Hoekstra" <Han.Hoekstra@WirelessValue.nl>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Has anyone seen these problems with the CSRBlueCore and BlueZ before ?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1111068128.11792.73.camel@pegasus>
Message-ID: <E1DBvrG-0002tO-0b@sc8-sf-mx1.sourceforge.net>
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
Date: Thu, 17 Mar 2005 15:19:44 +0100

Hey Marcel,

The info I get from hciconfig -a is :

hci0:   Type: UART
        BD Address: 00:A0:96:0A:BF:D4 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:303 acl:0 sco:0 events:13 errors:0
        TX bytes:434 acl:0 sco:0 commands:12 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x5df LMP Ver: 1.2 (0x2) LMP Subver:
0x5df
        Manufacturer: Cambridge Silicon Radio (10)

This info is what I get just after booting the board.

Greetings,
   Han

---
Han Hoekstra
Wireless Value B.V.
Waanderweg 30a
7812 HZ  Emmen
Tel: +31-591-633200

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: donderdag 17 maart 2005 15:02
To: BlueZ Mailing List
Subject: Re: [Bluez-users] Has anyone seen these problems with the
CSRBlueCore and BlueZ before ?

Hi Han,

> I'm developping an application on an ARM-7 based platform which is 
> running Linux 2.4.18 with the latest BlueZ version for that platform.
> In this application there is a master device that can connect to up to
> 7 slaves (master and slave devices are all the same, the external 
> controller determines which is master).
>  
> The application does the following, the external controller on the 
> master can send a single command to the Linux application, in the 
> command is an address field identifying to which slaves the command 
> must be passed on. A slave will pass the command on to its external 
> controller, which will respond to the command by sending a reply back 
> to the Linux slave, which in turn passes it on to the Linux master and 
> is then handed over to the external controller again. As soon as all 
> addressed slaves have responded, the sequence is repeated.
>  
> Now to what I see happening, when I run this with 5 slaves, I don't 
> see any problems for more than an hour, but when I run it with 6 or 7 
> slaves, I see that the BlueCore resets itself, with 6 slaves after 
> about 40 minutes and with 7 slaves already after 5 to 10 minutes. When 
> I eliminate the CRC check I can run the 7 slaves configuration for up 
> to about 40 minutes after it crashes.
>  
> What I think happens is that the BlueCore receives data to fast over 
> the air and can not pass it on to the Linux CPU quick enough, so there 
> is an internal overflow in the BlueCore.
> Communication between the BlueCore and the Linux CPU is done via BCSP 
> at a speed of 921600 baud.
>  
> Has anybody seen behaviour like this before and is there something I 
> can do about it ???

what does "hciconfig -a" tells you about the chip?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide Read honest & candid reviews
on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

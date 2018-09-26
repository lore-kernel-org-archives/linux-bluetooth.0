Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200402171142.i1HBgRV5023132@mail.holtmann.net>
From: grpmind+bluez.users@boromir.vpop.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
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
Date: Tue Feb 17 03:42:16 2004
To: undisclosed-recipients:;

Marcel Holtmann wrote:

> Hi,
>
>> I'd like to configure a linux box using a USB bt dongle to talk to an ipaq
>> at 723kbps for streaming video. So two questions:
>
> what iPAQ is this?
        
2215 running ppc2003
        
>> 1. How can I tell at what rate the two bluetooth devices are talking? I
>> could use l2test if I could run linux on the ipaq, but I can't (yet).
>
>
> Buy a protocol analyser
 
Ok. ;-)

>> 2. How can I configure the two to talk at the assymetric 723kbps rate?

> In general this is not needed, because the link manager should choose
> the best package types for you.

I think it's not working for me. Here's my setup:

linux 2.6.2 + USB bluetooth dongle (Actiontec); no other USB devices
connected

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:20:E0:3A:2E:57 ACL MTU: 2000:32  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:1717240 acl:19853 sco:0 events:99969 errors:0
        TX bytes:25192308 acl:134411 sco:0 commands:57 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'sermons.desiringGod.org-0'
        Class: 0x000104
        Service Classes: Unspecified
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x322 LMP Ver: 1.1 (0x1) LMP Subver: 0x322
        Manufacturer: Cambridge Silicon Radio (10)

(The default ACL MTU is 192:8; I tried cranking it up to no avail.)

For a poor man's throughput test I'm downloading a 7M mpeg file, both
through Pocket IE and by having Pocket TV stream it from my 100Mbps LAN.
I'm running "nload -o 800 -t 250 xl0" and watching the outgoing avg in
kbit/s.

No matter what I do, the average caps out at about 265kbps. I've tried all
the following in various combinations:

        hcitool cpt ipaqbdaddr dh5
        hcitool cpt ipaqbdaddr dm5
        hciconfig hci0 ptype dh5
        hciconfig hci0 ptype dm5
        hciconfig hci0 aclmtu 2000:32

Running "hcitool cpt ipaqbdaddr dm1" does slow the transfer down, but
nothing gets it going faster than 265kbps. I think I have a good link:

# hcitool rssi 00:04:3E:81:90:E0
RSSI return value: 0
# hcitool lq 00:04:3E:81:90:E0
Link quality: 255
# hcitool tpl 00:04:3E:81:90:E0
Current transmit power level: -8


Does all this mean that my ipaq has a slow UART?

Matt

P. S. Most of the ipaq 2215 docs are available at http://www.handhelds.org/platforms/hp/ipaq-h22xx/.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

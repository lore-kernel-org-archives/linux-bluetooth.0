Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie> <1082550752.23959.34.camel@pegasus>
In-Reply-To: <1082550752.23959.34.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404212148.19733.tim@birdsnest.maths.tcd.ie>
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
Date: Wed, 21 Apr 2004 21:48:18 +0100

On Wednesday 21 April 2004 13:32, Marcel Holtmann wrote:

> > I wonder if anyone has had a problem with Bluetooth in linux-2.6.5?
> > I have a Sony C1VFK Picturebook with built-in bluetooth.
> > Everything works fine in 2.6.3,
> > buit when I go to 2.6.5 I get the oops below.
> > I should say that this occurs after "service bluetooth restart"
> > and "spicctrl -l1"
> > (the latter being required to activate bluetooth on this machine).
> >
> > It is possible that this has nothing to do with bluetooth,
> > and is a USB problem.
>
> give 2.6.6-rc2 a shot, because it includes the outstanding Bluetooth and
> USB updates. If it still oopses report it on the USB mailing list.

Thanks for the suggestion.
This works fine, as shown below.
I also tried 2.6.4, which worked fine.
So it is only 2.6.5 which caused trouble.
I guess I can forget about it.

===========================================
[tim@martha linux-2.6.6-rc2]$ hciconfig -a
hci0:   Type: USB
        BD Address: 08:00:46:21:5C:E3 ACL MTU: 128:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:399 acl:0 sco:0 events:16 errors:0
        TX bytes:305 acl:0 sco:0 commands:15 errors:0
        Features: 0xff 0xff 0x05 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'martha.murphy.ie-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.0b (0x0) HCI Rev: 0x60 LMP Ver: 1.1 (0x1) LMP Subver: 0x60
        Manufacturer: Cambridge Silicon Radio (10)
===========================================

-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

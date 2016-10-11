Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Gladden <steve@michiganbroadband.com>
To: Barry Byford <31baz66@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 11 Oct 2016 13:52:27 -0400
Subject: RE: How can you set Transmit power level in Bluetooth LE mode for
 an LE beacon?
Message-ID: <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2D@X2.michiganbb.local>
References: <FEFD25773376F6448FE2884F5C1FA527F5E8622404@X2.michiganbb.local>
 <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2C@X2.michiganbb.local>,<CAAu3APZmaK_npAwEk9cd=KB8zqt2=DFnKJqV8Wd_QTUNi5vHrQ@mail.gmail.com>
In-Reply-To: <CAAu3APZmaK_npAwEk9cd=KB8zqt2=DFnKJqV8Wd_QTUNi5vHrQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks!!   
Yes it's nice to hear from somebody.  

I've been scouring the web so far to no avail on what I think should be a simple and accessible setting.    
It's obvious from the specs that most chips have a programmable (settable) transmitter power.  
And with beacons it is very important and expected that one should be able to adjust the transmitter level.   
All of the serial boards do it with simple AT commands.   

I just don't get why there's no documentation on how to do it with a USB device!!   

They sell class 1 bluetooth usb dongles for applications that require more range (100m) is quoted on most class 1 products.

I'd expect there should be a straight forward easy to set power in LE mode to get more range or save power and limit range when wanted.  

But I'm really not finding this information out there!   

I don;t understand what I am doing wrong or why this is so difficult to find.  :)
   






On 11 October 2016 at 17:50, Steve Gladden <steve@michiganbroadband.com> wrote:
> Is this this list just some kind of automated patch announcement log and not an actual mailing list where you can ask anything about bluetooth.
> This is all I have seen here for the past few days?
> Where can I ask an actual question about bluetooth?

There are some real humans here too!  :-)

If you look back on the archive of this list you will see a mixture of
questions and patch requests.
marc.info/?l=linux-bluetooth

I've kept quiet as I'm not sure I can answer questions. To offer some
shared experience, I can say that I've been experimenting with
(Eddystone) beacons on Linux single board computers accessing BlueZ
through the DBus API using Python. I also have not found a way to
change the power level of advertisements either. For what I'm doing,
just making sure the TX power in the Eddystone advert matches what the
dongle is actually broadcasting has been good enough.

Sorry I couldn't be of more help.

Regards,
Barry

>
>
>
>
> Steve Gladden
>
> Michigan Broadband Systems
> Connecting Your Business!
>
>
>
> +1 734.527.7150 Direct
> +1 248.327.4389 Fax
> steve@michiganbroadband.com
> www.michiganbroadband.com
>
> ________________________________________
> From: Steve Gladden
> Sent: Sunday, October 09, 2016 12:11 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: How can you set Transmit power level in Bluetooth LE mode for an LE beacon?
>
> Hi,
> My name is Steve and I am located in Ann Arbor Michigan USA.
>
> I am new  bluetooth LE and lately am obsessed with Bluetooth LE beacons and trying them out.
>
> I have read article after article and page after page about how people have setup up beacons with USB BT 4.0 interfaces
> as well as serial bluetooth boards.
>
> I am currently experimenting with a beacon running on a Raspberry Pi-B and using an external USB Bluetooth 4.0 class 1 dongle.
>
> My frustration is that I have not been able to find any useful information in how to change the Transmitter power level when in
> LE mode.
>
> The dongle appears to be working at default level below zero dbm.
>
> The whole point of building your own beacon this way is to be able to customize it and setting the power level is an important key item
> that should be easily accessible yet I find that NOBODY ever even mentions it let alone do they explain or provide a way to set the power.
>
>
> Every text that I have found that details beacon setups from command line never bother to mention setting beacon TX power.
>
> All the pages I have found seem to copy each other and repeat the same information over & over
> But never get around to even mentioning or discussing setting the power output level of the blutooth dongle.
>
> sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 [ 92 77 83 0A B2 EB 49 0F A1 DD 7F E3 8C 49 2E DE ] [ 00 00 ] [ 00 00 ] C5 00
>
> The byte just left of the last one is the "reported" TX level that you are transmitting at.
> Which means you're supposed to know (or guess?) what dbm level you are actually transmitting at and set it here to display to the world what your transmitter level is set to so they can range (guess or estimate distance from TX).
> This value does not influence or reflect actual transmit power.
>
> Please help!!
>
> Could use any pointers.
>
> I'm a hardware guy as well so not very experienced in software/programming but I'm willing to try anything to get control of this.
>
> Been at this for over a week and have some working beacons but no control of transmit power level.
>
> Am using Trendnet USB dongles which appear to use a Cambridge Chip.  But I'm not exactly sure which chip.
>
>
> :~# lsusb
> Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
>
>
> root@raspberrypi:~# hciconfig hci0
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 00:15:83:EA:0A:B9  ACL MTU: 310:10  SCO MTU: 64:8
>         UP RUNNING
>         RX bytes:780 acl:0 sco:0 events:50 errors:0
>         TX bytes:1110 acl:0 sco:0 commands:50 errors:0
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

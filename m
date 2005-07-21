Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: <fyp@dreamx.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth as ttyS0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1DvTw1-00021X-U4@server.broadrick.moe.edu.sg>
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
Date: Thu, 21 Jul 2005 13:49:29 +0800

Hi

Yes I'm using a rs232 dongle. I've got it setup using AT commands to
make it auto accept connections. So now the problem I'm facing is
setting up the USB dongle on the linux pc. I'm not really sure how to go
about doing it. Why use rfcomm instead of hciattach to attach the
bluetooth to ttys0 ?

player:~# hciconfig -a
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:12 acl:0 sco:0 commands:3 errors:0

hci1:   Type: USB
        BD Address: 00:80:98:74:22:A3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1900 acl:0 sco:0 events:52 errors:0
        TX bytes:732 acl:0 sco:0 commands:34 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (1)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33d LMP Ver: 1.1 (0x1) LMP Subver:
0x33d
        Manufacturer: Cambridge Silicon Radio (10)


In fact I'm totally new to bluetooth and linux, so I'm rather lost now. 


Jeremy


> 
> On 7/20/05, fyp@dreamx.org <fyp@dreamx.org> wrote: 
> > 
> > Hi!
> > 
> > I've having reading many sites and found that to bind a port for
> > bluetooth i need rfcomm. I've also tried the steps in doing it but it
> > doesn't seem like what I really wanted.
> > 
> > My objective is to make a USB Bluetooth dongle work as a Serial port
> > (i.e ttyS0). I've a USB Bluetooth dongle and a RS232 Bluetooth device.
> > This is to emulate a serial cable replacement.
> > A simple diagram of what I really want to achieve is osmething like
> > this:
> > 
> > |LinuxPC| USB<-->Bluetooth ~~~~~~ Bluetooth<-->RS232 |LinuxPC|
> 
>   I guess you are using rs232 bluetooth dongle in the right side. Then
first 
> of all, you need to know how to get the dongle works. For the usb
dongle , 
> kernel should dynamic detect and what you need to do is to setup hcid.
For 
> the RS232 dongle, you need additional command hciattach to setup the
dongle 
> and run hcid. 
>  Up to now , you should get something by "hciconfig -a". Then you
should use 
> rfcomm command from bluez-util to setup the link between computer.
>   Mike,Lee
> 
> 

-- 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

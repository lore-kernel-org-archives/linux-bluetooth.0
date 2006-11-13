Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <9f50a7a00611081458v172fea16q5bd0c78e1595f891@mail.gmail.com>
References: <9f50a7a00611081458v172fea16q5bd0c78e1595f891@mail.gmail.com>
Date: Mon, 13 Nov 2006 09:13:11 +0100
Message-Id: <1163405591.26272.33.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Is Bluetooth 2.0 supported/implimented by bluez ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Jerone,

> I have been trying to transfer files from my cellphone to my computer
> over bluetooth quickly. Both are bluetooth 2.0 and I noticed under
> linux that they do not transfer at much slower speed then under
> windows. After some investigation I have to assume that they are
> transfering using bluetooth 1.2 speeds & not bluetooth 2.0 speeds. My
> cell phone is a Nokia N73 & usb dongle is belkin bluetooth 2.0 class1
> usb dongle. I have tried this with Ubuntu Edgy & Fedora Core 6 using
> the gnome file sharing applet on the computer to get the files.
> 
> After reading the source code I see the the VHCI is has a decleration
> "define VERSION 1.2". Looking at the kernel code & bluez tools it does
> not look like bluetooth 2.0 is supported. But I can't find a
> definative answer anywhere.  Does anyone have any idea ?
> 
> Here is info on my bluetooth dongle:
> hci0:   Type: USB
>         BD Address: 00:0A:3A:6F:82:85 ACL MTU: 1017:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
>                 <transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps>
>                 <EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan>
>                 <interlaced pscan> <inquiry with RSSI> <extended SCO>
>                 <EV4 packets> <EV5 packets> <AFH cap. slave>
>                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
>                 <pause encryption> <AFH cap. master> <AFH class. master>
>                 <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps> <3-slot EDR eSCO>
>                 <extended features>
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver: 0x415c
>         Manufacturer: Broadcom Corporation (15)
>         Firmware 0.65 / 92
> 
> I also went out and got a Bluetake 700sx and still do not get 2.0
> speeds..what is going on. It looks like Bluez does not have Bluetooth
> 2.0 implimented.

both sides has to support EDR packets to achieve Bluetooth 2.0 speed and
BlueZ fully supports EDR and will use it whenever possible.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

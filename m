Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-users] TDK Firmware Upgrade Procedure....
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Super Smart <alwaysgone@seznam.cz>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, samlee@ptl.com.tw
In-Reply-To: <1053621298.17765.137.camel@pegasus>
References: <32124.50542-5451-1424036798-1053591000@seznam.cz>
	<1053621298.17765.137.camel@pegasus>
Content-Type: text/plain
Message-Id: <1053622053.1771.40.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 22 May 2003 17:47:34 +0100
List-ID: <bluez-users.lists.sourceforge.net>

I was unable to get this installed on our Win2k machines. hciconfig
currently reports: 

hci0:   Type: USB
        BD Address: 00:80:98:24:4E:8A ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2514 acl:37 sco:0 events:149 errors:0
        TX bytes:1355 acl:35 sco:0 commands:53 errors:0
        Features: 0xff 0xff 0x0d 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'bluez-server'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver:
0x86
        Manufacturer: Cambridge Silicon Radio (10)

On Thu, 2003-05-22 at 17:34, Marcel Holtmann wrote:
> Hi,
> 
> > This is from TDK's support:
> > -----------------------
> > 
> > Thank you for your email. Our Bluetooth device supports
> > Point-to-point and point-to-multipoint connections simultaneously.
> > Ensure that you are using the latest stack version 1.3.2.19 available
> > for download from our web site www.tdksystems.com. Assuming you are
> > using the latest stack, please upgrade the firmware on your device.
> > This utility is found on 
> > 
> > C:\Program Files\TDK Systems\Bluetooth Software\Bin\Bluetooth Device
> > Information. 
> > 
> > Simply run this utility and follow the on-screen instructions.
> > 
> > -----------------------
> 
> what kind of stack do TDK use? Is it the Widcomm one?
> 
> What firmware do you have now? What do "hciconfig -a" show?
> 
> Regards
> 
> Marcel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

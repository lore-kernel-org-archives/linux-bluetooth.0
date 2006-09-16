Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <450B3B01.2060801@gmail.com>
References: <beb7688e0609150702x738ad4d8re64815d12f457a76@mail.gmail.com>
	<1158329592.5233.32.camel@localhost>  <450B3B01.2060801@gmail.com>
Date: Sat, 16 Sep 2006 11:00:07 +0200
Message-Id: <1158397207.6839.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Celluon Laserkey Bluetooth Keyboard
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Chris,

> >> The last part is interesting, because the three 255s repeat for every
> >> keypress and mouse movement made with the device.
> > 
> > this is not a HID compatible keyboard and needs an extra driver to
> > function properly. Please run "sdptool records --raw <bdaddr>" to
> > retrieve the SDP records for this device.
> 
> Sure, here's the output:
> 
> $ sdptool records --raw 00:0B:24:40:C7:83
> Sequence
>          Attribute 0x0000 - ServiceRecordHandle
>                  UINT32 0x00010000
>          Attribute 0x0001 - ServiceClassIDList
>                  Sequence
>                          UUID16 0x1101 - SerialPort
>          Attribute 0x0004 - ProtocolDescriptorList
>                  Sequence
>                          Sequence
>                                  UUID16 0x0100 - L2CAP
>                          Sequence
>                                  UUID16 0x0003 - RFCOMM
>                                  UINT8 0x01
>          Attribute 0x0100
>                  String Serial Port
> 
> Please let me know if you need any other information, or if there's 
> anything I can do to help get this working.

this looks like the third of these. Please also run "hcitool inq" and
"hcitool info ..." (as root) for this.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Williams <dcbw@redhat.com>
In-Reply-To: <1152895689.14037.50.camel@localhost.localdomain>
References: <1152893105.14037.21.camel@localhost.localdomain>
	<1152894124.25660.33.camel@localhost>
	<1152894617.14037.45.camel@localhost.localdomain>
	<1152895158.25660.37.camel@localhost>
	<1152895689.14037.50.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 18:56:50 +0200
Message-Id: <1152896210.25660.39.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO MTU fix needed for Kensington Bluetooth USB
	Adapter
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

Hi Dan,

> > please also send "hciconfig hci0 features" (I don't like to decode that
> 
> [localhost ~]# /usr/sbin/hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
>                 <transparent SCO> <enhanced iscan> <interlaced iscan> 
>                 <interlaced pscan> <AFH cap. slave> <AFH cap. master> 
> 
> 
> > by hand). And check if "hciconfig hci0 inqmode 1" succeeds.
> 
> [localhost ~]# /usr/sbin/hciconfig hci0 inqmode 1
> [localhost ~]# 
> 
> (ie, nothing printed out)

if "hciconfig hci0 inqmode" return Inquiry with RSSI as mode then this
dongle also supports it, even if it is not mentioned in the features.

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

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608181617.59981.jwm@angrymonkey.net.nz>
References: <200608180117.02770.jwm@angrymonkey.net.nz>
	<1155839053.4075.160.camel@aeonflux.holtmann.net>
	<200608181617.59981.jwm@angrymonkey.net.nz>
Date: Fri, 18 Aug 2006 13:10:24 +0200
Message-Id: <1155899424.4075.179.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Keyboard woe
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

Hi John,

> >  please get us the SDP records for this device. Use sdptool with "browse"
> >  or "records" commands to fetch them. You might have a non-HID device
> >  that needs special support in hidd.
> 
> > sdptool records 00:0A:3A:30:D4:40
> Service Name: SPP slave
> Service RecHandle: 0x10000
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100

please redo it with "sdptool records --raw <bdaddr>".

> I stumbled on a useful review of the device, under the Freedom brand:
> 
> http://www.geekzone.co.nz/content.asp?contentid=5236
> 
> So it's definitely a serial rather than HID device. How much of a struggle 
> would it be to build drivers for it, given that there is already similar code 
> for the EPoX presenter?

You need to know what protocol are they using or I need a donation of
such a keyboard to actually hack the protocol.

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

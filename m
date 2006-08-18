Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: John Morton <jwm@angrymonkey.net.nz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 18 Aug 2006 16:17:59 +1200
References: <200608180117.02770.jwm@angrymonkey.net.nz>
	<1155839053.4075.160.camel@aeonflux.holtmann.net>
In-Reply-To: <1155839053.4075.160.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200608181617.59981.jwm@angrymonkey.net.nz>
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

On Friday 18 August 2006 06:24, Marcel Holtmann wrote:
>
>  > Inquiring ...
>  >         00:0A:3A:30:D4:40       clock offset: 0x60be    class: 0x001f00
>  >
>  > > hcitool info 00:0A:3A:30:D4:40
>  >
>  > Requesting information ...
>  >         BD Address:  00:0A:3A:30:D4:40
>  >         Device Name: KEYBOARD
>  >         LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2
>  >         Manufacturer: Cambridge Silicon Radio (10)
>  >         Features: 0xbc 0x06 0x07 0x00 0x00 0x00 0x00 0x00
>  >                 <encryption> <slot offset> <timing accuracy> <role
>  > switch> <sniff mode> <RSSI> <channel quality> <CVSD> <paging scheme>
>  > <power control>

>  please get us the SDP records for this device. Use sdptool with "browse"
>  or "records" commands to fetch them. You might have a non-HID device
>  that needs special support in hidd.

> sdptool records 00:0A:3A:30:D4:40
Service Name: SPP slave
Service RecHandle: 0x10000
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

I stumbled on a useful review of the device, under the Freedom brand:

http://www.geekzone.co.nz/content.asp?contentid=5236

So it's definitely a serial rather than HID device. How much of a struggle 
would it be to build drivers for it, given that there is already similar code 
for the EPoX presenter?

John


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

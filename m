Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1161027393.3860.18.camel@localhost.localdomain>
References: <1161027393.3860.18.camel@localhost.localdomain>
Date: Wed, 18 Oct 2006 19:17:22 +0200
Message-Id: <1161191842.30606.16.camel@localhost>
Mime-Version: 1.0
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] Address endianess?
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

Hi Per Thomas,

> Is there a standard ordering of the bytes in a bluetooth address?  
> 
> On my linux box (2.6.12.1):
> # hcitool dev 
> Devices:
>         hci0    00:02:72:C0:7C:2B
> 
> But when my phone (Sony Ericsson K800i) discovers my server, I get this
> address for the server:
> 
> 2B7CC0720200 
> 
> This is from the Java bluetooth api on the device. And yes, I have to
> reverse that address in order to connect to the server.

the Bluetooth device address (BD_ADDR for short) is an IEEE address and
it is always transmitted in reverse order.

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

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=22=EC=9D=B4=EA=B4=91=EC=A7=84=22?= <fidelis98@naver.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44FE0B6A.000001.04824@nhn528>
References: <44FE0B6A.000001.04824@nhn528>
Date: Fri, 15 Sep 2006 14:00:21 +0200
Message-Id: <1158321621.5233.21.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluez HID support Think Outside Keyboard????
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

Hi,

> My question is,
> 
> Have you ever used Think-Outside Bluetooth keyboard with BlueZ?
> I connect to Think-Outside BT Keyboard and run server.
> 
> # hidd --search
>     Connecting to device 00:03:C9:D3:79:25
> 
> # hidd
> 00:03:C9:D3:79:25 HID Boot Device [0a5c:2001] connected
> [boot-protocol]
> 
> # hidd -n --server
> hidd[1118]: Bluetooth HID daemon
> 
> After run  "hidd -n --server ", wait polling data from device.
> 
> But, Data is nothing.
> 
> How about your connection to Think-Outside BT Keyboard? 
> Like me? or not ?
> 
> How can I solve this problem?

that is enough to do. Run "hcidump -X -V" as root to see if keypresses
get transmitted.

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

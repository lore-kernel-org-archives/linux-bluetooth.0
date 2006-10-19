Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45376FBA.8070402@gmx.de>
References: <45376FBA.8070402@gmx.de>
Date: Thu, 19 Oct 2006 14:42:56 +0200
Message-Id: <1161261776.27710.44.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] how to disable l2cap kernel messages?
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

Hi Sandro,

> My syslog is full with messages like:
> 
> Oct 19 14:26:58 x545 kernel: l2cap_recv_acldata: conn ffff81003ed5d8c0
> len 14 fl
> ags 0x2
> Oct 19 14:26:58 x545 kernel: l2cap_recv_frame: len 10, cid 0x0041
> Oct 19 14:26:58 x545 kernel: l2cap_data_channel: sk ffff81002b743400 len
> 14 mode
>  0x00
> 
> how do I dissable these messages?

you have to compile your kernel without debug messages. Or is this a
kernel with -mh patch and I left them on by accident.

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

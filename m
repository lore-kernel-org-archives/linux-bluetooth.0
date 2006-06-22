Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060622135351.253940@gmx.net>
References: <20060622131954.253990@gmx.net>
	<1150983661.13991.51.camel@localhost> <20060622135351.253940@gmx.net>
Date: Thu, 22 Jun 2006 16:44:03 +0200
Message-Id: <1150987443.13991.55.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid does not start. Can't
	open	system	message	bus connection
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

Hi Hans-Juergen,

> Where can I download earlier Versions???

they are in the same directory.

> How to access the cvs???

Check the website. It contains detailed information.

> I dont want to start something that I dont need. No part of my system do need the system message bus. For what??? The machine I use is a diskless X terminal. And therefor I dont want to load the CPU and memory with something I dont need.

The new BlueZ D-Bus API uses D-Bus and thus you need it. Over time the
D-Bus will become an integral service of BlueZ.

> Installation of a newer distribution is not possible because non will let me install the system from a NFS server only by booting the kernel and setup some parameters. Diskless means diskless. No floppy no CD only a remote boot prom.

What has that to do with a newer distribution and D-Bus. Anyway, use the
system your are comfortable with.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

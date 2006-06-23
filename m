Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E1Ftu0w-0005Bn-Uc@mail.sourceforge.net>
References: <E1Ftu0w-0005Bn-Uc@mail.sourceforge.net>
Date: Sat, 24 Jun 2006 01:19:12 +0200
Message-Id: <1151104752.3281.62.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] ACL Connection Handles
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

Hi Kevin,

> Because of the single ACL connection limit between two devices, this
> list has recommended to use bluez to open new connections rather than
> direct HCI manipulation.  
> 
> Once the connection is active and in the connection hash list, how can
> one extract the handle out again to start raw HCI packet slinging?
>  Looking at the kernel source, there is a hci_conn_hash_lookup_ba
> function that seems promising, or is there another method that I am
> missing.

check the source code of l2test and rctest. It will show you how the get
the underlaying connection handles for L2CAP and RFCOMM connections.

Regards

Marcel




Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

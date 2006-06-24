Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Kevin Mahaffey" <kevin.mahaffey@flexilis.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Fri, 23 Jun 2006 17:51:03 -0700
MIME-Version: 1.0
in-reply-to: <1151104752.3281.62.camel@localhost>
Message-ID: <E1FtwMl-0004Dc-OI@mail.sourceforge.net>
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

Marcel,

Thanks.  l2test has exactly what I need.

-Kevin

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, June 23, 2006 4:19 PM
To: BlueZ development
Subject: Re: [Bluez-devel] ACL Connection Handles

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
Get stuff done quickly with pre-integrated technology to make your job
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

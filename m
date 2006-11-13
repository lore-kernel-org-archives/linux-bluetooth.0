Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Rupesh Gujare <rupesh_gujare@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061107082838.28192.qmail@webmail70.rediffmail.com>
References: <20061107082838.28192.qmail@webmail70.rediffmail.com>
Date: Mon, 13 Nov 2006 09:24:07 +0100
Message-Id: <1163406247.26272.50.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] How can i change MTU to max value?
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

>   I am programming for transferring data between my Linux box and
> mobile phone. But while transferring large files it takes quiet a few
> time. 
>   I want to achieve maximum data transfer rates without affecting
> reliability of system. I am using "object push service" for this. And
> tried changing default MTU size in /usr/include/openobex/obex_const.h
>   But got same results.
>   Can anyone tell me how can i increase MTU size? Or is there any
> limitation on it? (I think Max. MTU size can be 64k).

the maximum MTU is used by default.

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid doesn't compile without --enable-dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <ef9938ec0604211458s3cccaca3q47555f9af8418582@mail.gmail.com>
References: <ef9938ec0604211458s3cccaca3q47555f9af8418582@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1145666139.4914.3.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 22 Apr 2006 02:35:39 +0200

Hi Albert,

> I get the following error when trying to compile utils from CVS
> without --enable-dbus
> 
> security.c: In function 'disconn_complete':
> security.c:614: warning: passing argument 2 of
> 'hcid_dbus_disconn_complete' makes pointer from integer without a cast
> security.c:614: error: too many arguments to function
> 'hcid_dbus_disconn_complete' 
> 
> Attached patch appears to fix it.

the patch has been applied. Thanks.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

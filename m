Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60608301504l19d81775vde1d7be054c6e62d@mail.gmail.com>
References: <be976db60608301316g5945d06apd3b98264fe8e2405@mail.gmail.com>
	<1156980766.4026.111.camel@aeonflux.holtmann.net>
	<be976db60608301504l19d81775vde1d7be054c6e62d@mail.gmail.com>
Date: Thu, 31 Aug 2006 02:41:08 +0200
Message-Id: <1156984868.4026.114.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] location of link keys
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

Hi Mark,

> Thanks for your reply.  That is what I thought except that 
> once I disconnect from the device, my /var/lib/bluetooth directory is
> emptied.    So I am curious how they get wiped out.

at least not by hcid, because this option doesn't exists. I assume the
never get written. At least you should see a subdirectory for your local
BD_ADDR and the linkkeys file. If you have SELinux, it can be a problem
if not correctly configured. Did you check the syslog for possible error
messages?

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

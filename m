Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <28c817710606290543i3f331478ta461242dcc94d612@mail.gmail.com>
References: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
	<6297d67c0606290445h455ea56bjfdf3bc2b44f26ad1@mail.gmail.com>
	<1151582944.14964.17.camel@localhost>
	<28c817710606290543i3f331478ta461242dcc94d612@mail.gmail.com>
Date: Thu, 29 Jun 2006 18:02:53 +0200
Message-Id: <1151596973.14964.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] how to create a ACL connection with
	an	authentication?
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

> if I need to build the authentication connection in my own
> program,what should I do?
> what I know is use the socket API to create a connection.but how to
> set this connection to have an authentication?

for L2CAP/RFCOMM you can use socket options to request authentication
and encryption on incoming connections. Take a look at the source of
rctest.c and l2test.c.

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

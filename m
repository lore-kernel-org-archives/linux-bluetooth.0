Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e0638ac60606301533r646d798dle31901ed4583b165@mail.gmail.com>
References: <e0638ac60606301533r646d798dle31901ed4583b165@mail.gmail.com>
Date: Mon, 03 Jul 2006 17:17:43 +0200
Message-Id: <1151939863.12125.21.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO link for data packets
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

Hi Eunsoo,

> I have two questions.
> 
> 1. Is it possible to use SCO link for data packet transmissions (not audio)?

in theory it is possible to use the transparent codec and send data over
the SCO link, but in the end it is audio data that will be processed by
a codec. And this means that there is not guarantee that you will
receive the same data on one side that you sent on the other side.

> 2. Is there any documentation for bluez sco programming?

Not really. Check the source code files in bluez-utils.

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

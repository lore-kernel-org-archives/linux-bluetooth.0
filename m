Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <52950c3f0702110835g10106667jd8034fc66536aa7c@mail.gmail.com>
References: <52950c3f0702110835g10106667jd8034fc66536aa7c@mail.gmail.com>
Date: Mon, 12 Feb 2007 20:38:06 +0100
Message-Id: <1171309086.11774.13.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] connect() returns "Operation already in progress"
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

Hi Timur,

> I'm trying to write a simple client/server application to communicate
> between a Motorola A780 phone and a bluetooth usb dongle.
> Interestingly enough when I run the server application on my laptop,
> to which the dongle is attached, the client application on the phone
> returns "Operation already in progress" when connect is called. On the
> other hand, when I run the server on the phone and connect from my
> laptop, it works fine. What could be causing this? 

run "hcidump -X -V" to see what is causing this error message.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

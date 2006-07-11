Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60607061016yf4cebb1mda306e5c3912b2bc@mail.gmail.com>
References: <be976db60607061016yf4cebb1mda306e5c3912b2bc@mail.gmail.com>
Date: Tue, 11 Jul 2006 13:18:07 +0200
Message-Id: <1152616687.15028.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcidump output
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

> When connecting to my device, I got a "Connection timeout" from sdpd.
> I did an hcidump but I have no idea how to interpret the output.
> Specifically, there is a "Command Disallowed" but I don't see what the
> command is.  Is there a guide online explaining how to interpret
> hcidump 
> results?

you are in security mode 3. This is not a wise choice and unless you
really know what you are doing, don't use it.

You also ask for a serial port profile record, but there is non, so an
error will be returned.

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

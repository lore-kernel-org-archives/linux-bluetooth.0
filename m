Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <450E07FC.30700@xmission.com>
Date: Sun, 17 Sep 2006 20:44:12 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20060917202558.GG21347@compendium.com.ar>
In-Reply-To: <20060917202558.GG21347@compendium.com.ar>
Subject: Re: [Bluez-devel] bluetooth dies when trying to use 2 sco links
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

Horacio

fyi... over a year ago, Marcel wrote this cryptic note on multiple sco
connections:

===========
starting with 2.6.10 the hci_usb got a module parameter "isoc". This
controls the alternate setting when plugging in a dongle. The default
value is 2 (or 0 if it is blacklisted device). Check the Bluetooth
specification what value you have to choose for 2 x 16-bit SCO channels.
===========

If you're not able to find that value, you could try experimenting with
different values.

I was not able to find out what happens if the value is set higher than
you really need it. Would it hurt to load hci_usb with isoc set to the
value for two headsets even if you usually only use one? I don't know.

> Running just one instance of it with just one phone, it works great.
> When I try to run two instances, each connected to a different phone, it
> works for a few seconds and then all the SCO data stops flowing 

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

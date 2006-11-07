Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45511DA6.2000906@xmission.com>
Date: Tue, 07 Nov 2006 16:58:30 -0700
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

> Attached you'll find the code for a test program that makes a call using
> the hands-free profile connected to a cell phone and when the call is
> answered it generates echo (so the person who answers the phone will
> hear himself)

I talked with Marcel about this. Here's the current situation:

uart-connected bluetooth adapters can do multiple sco connections
without any trouble.

usb-connected bluetooth adapters suffer from a limitation in the usb
kernel layer... the number of sco connections has to be hardcoded at
boot time in the isoc parameter. If it's set for two 16-bit sco
connections, when more or fewer connections are in use, no audio gets
through. The usb layer needs a rewrite to fix this.

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

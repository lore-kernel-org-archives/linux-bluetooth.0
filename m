Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f3jl24$tmp$1@sea.gmane.org>
References: <f3ev58$iku$1@sea.gmane.org>
	<1180411455.21432.114.camel@aeonflux.holtmann.net>
	<f3i8fk$tfv$1@sea.gmane.org>
	<1180510319.21432.158.camel@aeonflux.holtmann.net>
	<f3jl24$tmp$1@sea.gmane.org>
Date: Wed, 30 May 2007 13:51:02 +0200
Message-Id: <1180525862.21432.186.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Increasing HIDP_DEFAULT_MTU ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pascal,

> > do you mean the controller that comes with the PS3?
> 
> Yes, a.k.a. "sixaxis".  It is not really advertised as a HIDP
> device, but it behaves pretty much like one.  Sony also has a
> TV-style Bluetooth remote, which I have not tested.

actually I have both of them. The controller is kinda nasty and I have
to integrate the cable-based authentication somehow nicely with udev and
the input service.

The remote uses a total weird HID report format. Doesn't make sense to
push that through the kernel. We will use a fake HID inside the input
service and then uinput to create the input device.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

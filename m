Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1161577973.9075.22.camel@localhost>
References: <1161577973.9075.22.camel@localhost>
Date: Mon, 23 Oct 2006 09:18:45 +0200
Message-Id: <1161587925.7694.2.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sony Ericsson HBH-610a Headset
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

Hi Jon,

> The linux kernel being used in both instances is 2.6.18.1. The 5150
> needed to be patched to force sco mtu values - manually done since
> 2.6.18.1 has code changes in the relevant area since the production of
> the patch. Before the application of this, everything would work in the
> connection step up to generating sounds. At that point, the sound
> program would hang (e.g. aplay would hang and no sound would be
> produced, although there was lots of activity shown in hcidump).
> 
> The 9400 required no patch.

send in the content of /proc/bus/usb/devices and the output of lsusb and
I fix that in the upstream kernel. You can also use the force_scofix
parameter of the hci_usb driver to force the SCO MTU values fix without
changing the kernel code.

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

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200702071644.02277.fernando@bluexare.org>
References: <200702071644.02277.fernando@bluexare.org>
Date: Mon, 12 Feb 2007 20:44:21 +0100
Message-Id: <1171309461.11774.22.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Pairing event in a module
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

Hi Fernando,

> I'm trying to develop an application that works with mobil devices.
> 
> I want to caugth the pairing event to do some things...
> 
> Only I need the device address of it, when the device pairs to me.
> 
> I have been seen the code, but I don't know how I can integrate to my module.
> 
> The link_key_notify shows when a device have paired with me, but how can 
> I "listen" until the launch of this method?
> How I can listen the EVT_LINK_KEY_NOTIFY event?
> 
> Which method launch this events??
> 
> I have seen that io_security_event do something with this events when they are 
> launched, but..., Who launch them?
> 
> Or, if i can listen these envets, It would be sufficient for me.

use the D-Bus API and listend to BondingCreated signals. Playing on the
low-level HCI is not a good idea at all.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

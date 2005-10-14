Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] indication of Class 1 or Class 2 devices 
In-reply-to: <8664s05ro4.fsf@coulee.tdb.com> 
References: <8664s05ro4.fsf@coulee.tdb.com>
From: Peter Stephenson <pws@csr.com>
Message-ID: <EXCHANGE03LjtVhvob600005bd1@exchange03.csr.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 14 Oct 2005 11:40:13 +0100

Russell Senior wrote:
> Is there a way, via /proc or /sys or something to discover whether a
> bluetooth device is Class 1 (100m) or Class 2 (10m)?

It's actually pretty difficult even if you have low level access to
the device, never mind via the OS.  There's no standardised way of
providing the information, and in the simplest case the module
manufacturer may simply have stuck a power amplifier onto the
transmitter.  If they do that they are supposed to provide
enough information for the device to support power control, however,
so if you can get access to that information you should be able to tell.

If it's a CSR device, you can find an interface to persistent store and
look at PSKEY_LC_POWER_TABLE (0x001e) or PSKEY_LC_ENHANCED_POWER_TABLE (for
devices with EDR, 0x0031).

Otherwise, you're stuck with seeing what power it's actually outputting
at its maximum setting by using a remote device and some measurement
equipment.

By far the easiest way is to go 100m away with another class 1 device
and see if it stays connected.  (Of course, you may be simply
testing the receiver sensitivity; in good conditions you can get
a lot more than 100m as a maximum once you're connected.)

pws


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

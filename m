Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E6FF208A16840D4EBAA31D261B15A506F29F16@ausx3mpc121.aus.amer.dell.com>
References: <1207335282.19116.5.camel@mlimonciello>
	<1207341998.32219.1.camel@mlimonciello>
	<1207351025.13201.328.camel@cookie.hadess.net>
	<E6FF208A16840D4EBAA31D261B15A506F29F16@ausx3mpc121.aus.amer.dell.com>
Date: Sun, 06 Apr 2008 23:42:04 +0100
Message-Id: <1207521725.3396.4.camel@cookie.hadess.net>
Mime-Version: 1.0
Cc: Mario_Limonciello@Dell.com
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching
	support	fornewer	Dell BT cards
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


On Sat, 2008-04-05 at 10:58 -0500, Mario_Limonciello@Dell.com wrote:
> Bastien,
> 
> I'll be glad to update the coding style to match the rest of the
> source.  Please see the updated attachment.  Both of these adapters
> are just bluetooth cards that ship on the laptop, not the dongles that
> come with a keyboard or mouse.
> 
> This is the way the cards function in Windows, and the way that they
> were intended to function.  When paired with a HID keyboard and/or
> mouse, they have the ability to store that pairing in the firmware.
> That's why they have the two modes.

Right. Do you have any documentation on how to store that pairing
information inside the adapter, or does it work out of the box in Linux
already?

> In reading your question, do you have a problem with a particular
> mouse &/or keyboard combo that the dongle isn't working 'out of the
> box'?

I've mainly got experience with Logitech dongles and Apple internal
adapters that do the same, but we're lacking documentation to make those
work properly.

Any documentation about the Dell kit would help.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 21 Apr 2008 11:36:19 -0500
Message-ID: <E6FF208A16840D4EBAA31D261B15A506F29F90@ausx3mpc121.aus.amer.dell.com>
References: <1207335282.19116.5.camel@mlimonciello><1207341998.32219.1.camel@mlimonciello><1207351025.13201.328.camel@cookie.hadess.net><E6FF208A16840D4EBAA31D261B15A506F29F16@ausx3mpc121.aus.amer.dell.com><1207521725.3396.4.camel@cookie.hadess.net><E6FF208A16840D4EBAA31D261B15A506F29F23@ausx3mpc121.aus.amer.dell.com>
	<E6FF208A16840D4EBAA31D261B15A506F29F5C@ausx3mpc121.aus.amer.dell.com>
From: <Mario_Limonciello@Dell.com>
To: <bluez-devel@lists.sourceforge.net>,
	<bluez-devel@lists.sourceforge.net>, <hadess@hadess.net>,
	<bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCIswitchingsupportfornewer	Dell
	BT cards
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

Hi Guys,

I've seen at least one other patch that flew by added to CVS already.  Are there any other objections that just haven't been vocalized regarding this patch?

Regards, 

Mario Limonciello 
Dell | Linux Engineering 
Mario_Limonciello@Dell.com 



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net on behalf of Mario_Limonciello@Dell.com
Sent: Sun 4/13/2008 11:34 AM
To: bluez-devel@lists.sourceforge.net; hadess@hadess.net; bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCIswitchingsupportfornewer	Dell BT cards
 
Bastien,

I spoke with some folks regarding documentation, and they are weighing
their options on the best route to do development on these devices.
(Releasing documentation, or doing patches themselves and submitting).

Speaking of which, has my patch been applied to the tree yet?


Mario Limonciello 
Dell | Linux Engineering 
Desk : (512) 723-0582 
Mario_Limonciello@Dell.com 



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net on behalf of Mario_Limonciello@Dell.com
Sent: Sun 4/6/2008 7:58 PM
To: hadess@hadess.net; bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switchingsupportfornewer	Dell BT cards
 
Bastien,

I don't believe the BlueZ/hci_usb setup can currently store the pairing in the adapter, but I'll investigate this week.  Currently the infrastructure should allow a pairing that was set in Windows to still live inside the adapter and transition to Linux per my understanding.

I'll see what documentation I can obtain from our Bluetooth Team that would be available for public release.  No promises there though :)


Mario Limonciello 
Dell | Linux Engineering 
Desk : (512) 723-0582 
Mario_Limonciello@Dell.com 



-----Original Message-----
From: Bastien Nocera [mailto:hadess@hadess.net]
Sent: Sun 4/6/2008 5:42 PM
To: BlueZ development
Cc: Limonciello, Mario
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching supportfornewer	Dell BT cards
 

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


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

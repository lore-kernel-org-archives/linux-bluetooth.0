Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1207341998.32219.1.camel@mlimonciello>
References: <1207335282.19116.5.camel@mlimonciello>
	<1207341998.32219.1.camel@mlimonciello>
Date: Sat, 05 Apr 2008 00:17:05 +0100
Message-Id: <1207351025.13201.328.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching support for
	newer	Dell BT cards
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


On Fri, 2008-04-04 at 15:46 -0500, Mario_Limonciello@Dell.com wrote:
> Hi,
> 
> As it turns out, this also works for the Dell 410 series cards.
> Attached is an updated patch to include them.

Only problems I could see with the patch is the coding style (C++-style
comments, braces on different lines for a condition, alignment of
arguments to a function when on multiple lines).

The rest of the code looks fine to me.

Are those adapters usually shipped with keyboards and mice, so that they
would need to stay in HID mode on startup?

If they do, do you have any code available that would make sure this
keyboard and mouse are registered in BlueZ so they work "out of the
box"?


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

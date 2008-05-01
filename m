Return-Path: <cyrus@holtmann.org>
Message-ID: <48196709.9030104@magtech.com.au>
Date: Thu, 01 May 2008 16:45:29 +1000
From: Aras Vaichas <arasv@magtech.com.au>
MIME-Version: 1.0
To: Bluez Users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluez + dbus for ARM solutions?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

can someone point me to where I can find scripts/patches that will help
me build ARM cross-compiled versions of Bluez + dbus for ARM?

Is there a well know set of dbus+bluez versions that are known to work
for cross-compiling, or does everyone just hack the configure files
until it works?

I'm currently stuck in dependency hell trying to get dbus to
cross-compile. So far I've got expat, bluez-libs,  and libusb compiled.

I saw that someone recommended Scratchbox (for dbus) but I'd rather not
do that because I am able to cross-compile every single other library
and application for my distribution (including Python) without requiring
a method like Scratchbox.

Aras Vaichas

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

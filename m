Return-Path: <cyrus@holtmann.org>
From: "Phil Endecott" <spam_from_bluez_users@chezphil.org>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 22 Apr 2008 15:58:44 +0100
Message-ID: <1208876324686@dmwebmail.dmwebmail.chezphil.org>
MIME-Version: 1.0
Subject: [Bluez-users] Apple wireless keyboard
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

Dear Bluetooth experts,

I think I am probably the bazillionth person to ask here about how to
get the Apple wireless keyboard to work properly with Linux.  Some of
the people who've solved the problem before have posted how-to pages
with recipes that worked for them, but unfortunately without really
understanding what was going on, or containing distribution-specific or
out-of-date information.  My keyboard is basically working now, but I'm
hoping that you can help me to understand what is really going on and
what is the right way to do it.

Firstly, I understand that some USB Bluetooth dongles have a "HID Mode"
where they appear as USB HID devices and all of the Bluetooth
complexity is avoided.  That would be ideal for me, but I suspect that
my dongle doesn't support that mode of operation; this page:
http://times.usefulinc.com/2004/06/12-hidproxy says that (in 2004) only
the CSR chips had this feature; is this still true?  My dongle is
(lsusb) "1131:1004 Integrated System Solution Corp." which doesn't look
like CSR.  I bought it cheapo on Ebay.  Is there a reliable way to
obtain a USB dongle with a CSR chip with this feature?  And how does
pairing work in this HID mode?  (Is it secure?)

Anyway, for the time being I have set it up the "hard way" as a real
Bluetooth keyboard.  I did this by

- Installing a kernel with the bluetooth modules.
- Installing bluez-utils.
- Starting hidd and hcid (enabling them in /etc/default/bluetooth on
this Debian box)
- Running passkey-agent --default 1234 (Debian ships this source for this)
- Running hcitool scan to get the keyboard address (which I've now
written on the back)
- Running hidd --connect <addr> and typing 1234RET on the keyboard

Now, if I understand things correctly, this PIN pairing should be a
one-off thing; there is now a file in /var/lib/bluetooth/..../linkkeys
which I presume is a key that can be used subsequently instead of the
PIN procedure - right?  (BTW, the .... in the pathname above is not the
keyboard's address; it has lots of 0s at the end.  What is it?)  So
after I reboot the keyboard should be able to connect without user
interaction.  But so far I have failed to make this happen.  I have
only been able to reconnect by deleting various things and starting
from fresh.  What do I need to do?  Do I need to add it to a
configuration file somewhere?  Do I need to arrange for hidd --connect
to be run?

Many thanks for any suggestions.

Phil.







-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

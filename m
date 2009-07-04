Return-Path: <cyrus@holtmann.org>
Message-ID: <4A4F8527.9090906@theserrs.net>
Date: Sat, 04 Jul 2009 10:36:55 -0600
From: Scott Serr <serrs@theserrs.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: help debugging: rfcomm connect but no data (on AT / OK)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I hope someone can help me connect to my old Treo 650.  I can do it on 
one machine, but not three others.

Desktop/Gigabyte - Ubuntu 8.10 - works, AT commands, I get a PPP connection
Dell D610 Notebook - 8.04 / 9.04 - doesn't work, no AT command / OK
Compaq Notebook - 8.10 - doesn't work, no AT command / OK
Del Mini 9 - 9.04 - doesn't work, no AT command / OK

I've scratched my head for hours.  I use the SAME bluetooth dongle on 
all 4 computers.

Details:
I went back to "minicom" because my PPP chat script seemed to not get an 
"OK" from AT commands.  Setup minicom to use /dev/rfcomm0 115200 8N1.  
On the Desktop above the AT commands work, but on the 3 notebooks AT 
never returns an OK.  Specifically on the notebook, the minicom screen 
is flashing/rewritten like a a stream of invisible characters are being 
written to it.

It seems like maybe port speeds are not the same?

I also ran l2ping, I get just 1 response... then it says "Recv failed: 
Connection reset by peer".  On the desktop it will respond forever.  If 
I put the Treo 650's Bluetooth in normal mode instead of "Dialup 
Networking" then l2ping will work fine on the notebook.

Seems like negotiation issues or timing issues?  I can't pinpoint bad 
hardware.  Looking for some direction?!

Thanks!
-Scott Serr

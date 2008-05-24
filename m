Return-Path: <cyrus@holtmann.org>
Message-ID: <48379DAE.7000603@earthlink.net>
Date: Fri, 23 May 2008 23:46:38 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: Bluez-Users-List <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Anycom USB-250 won't enter discoverable mode
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

I have an Anycom USB-250 that won't enter discoverable mode with bluez 
3.7. I'm pretty sure that I've followed the instructions properly from 
here: http://howto.pilot-link.org/bluesync/index.html

However, it doesn't work. When I try to get my Palm T|X to scan for 
Bluetooth devices, it sees nothing. This is under Debian Etch (i386) 
with bluez-utils 3.7-1. I'm running kernel 2.6.24.6.

I'm looking at two possible sources of the problem: 1) a bluez software 
failure (probably in sdpd) or 2) a firmware requirement for the Anycom.

Sdpd seems to enable SDP by default; however, I wouldn't begin to know 
how to evaluate if SDP actually working.

For the firmware requirement, I've installed bluez-firmware, but the 
package seems to do nothing. The /usr/share/doc/bluez-firmware/README 
file only discusses compilation and installation, and README.Debian only 
says that hotplug is requires, but hotplug is not compatible with Etch.

I need to find out how to use the binary firmware files in 
/usr/lib/firmware (which are evidently intended for my adapter). The 
Anycom USB-250 has a Broadcomm chipset, and I've heard that Broadcomm 
needs firmware to work.

Someone please tell me how to get either sdpd to work properly or the 
firmware installed. Thanks.

(I also asked a similar question in debian-user.)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

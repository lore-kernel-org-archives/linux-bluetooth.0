Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geoff Shang <geoff@hitsandpieces.net>
To: blinux-list@redhat.com, general@lists.humbug.org.au,
        bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0603181246420.738@data.home>
Message-ID: <Pine.LNX.4.64.0603212358080.738@data.home>
References: <Pine.LNX.4.64.0603181246420.738@data.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Re: [H-GEN] Bluetooth: pand: Connection failed. File exists(17)
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
Date: Wed, 22 Mar 2006 00:05:11 +1000 (EST)

Geoff Shang wrote:

> Mar 10 18:35:46 data pand[16077]: Connection failed. File exists(17)

Thanks to those who helpfully suggested I run pand under strace. 
Unfortunately, for me at least, the results weren't particularly 
illuminating.

I'm assuming the following line from the panu side is significant:

ioctl(3, 0x400442c8, 0xbffff210)        = -1 EEXIST (File exists)

Anyone know what this means?

If it matters, ifconfig seems to show bnep0 as already existing, but not 
configured.  Should it go away when pand isn't running, and if so, how can 
I make it go away (i.e. would this be causing my problem?)

I'll send anyone interested in helping a copy of the entire strace output 
if they want it, but I don't want to bore three lists with it.

Any help appreciated.

Geoff.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

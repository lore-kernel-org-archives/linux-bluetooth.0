Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-sdp depreciated? Was Which fedora core?
From: Philip Barnes <phil@trig222.f9.co.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100861560.7136.49.camel@baroque.rococosoft.com>
References: <cnhnd6$toe$1@sea.gmane.org>  <1100769119.7164.17.camel@pegasus>
	 <1100798738.3439.4.camel@localhost.localdomain>
	 <1100803683.7164.74.camel@pegasus>
	 <1100808919.3433.12.camel@localhost.localdomain>
	 <1100813353.7164.87.camel@pegasus>
	 <1100861560.7136.49.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1101329008.3773.10.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 24 Nov 2004 20:43:28 +0000

On Fri, 2004-11-19 at 10:52 +0000, Stephen Crane wrote:
> You can fool your installation into thinking libsdp is there by
> softlinking it to libbluetooth. Hacky but it works.
> 
> # ln -s /usr/lib/libbluetooth.so /usr/lib/libsdp.so
> 
Thanks for that idea Steve, I've not managed to get it working with the
core 3 files as I have other problems with dynamic devices and I am
trying to solve one problem at a time. 

At present I have un-installed the bluez files from core 3 and installed
core 2. I have created rfcomm0 and rfcomm1 in /etc/udev/devices, they
are then created in /dev at start-up. At this point I can connect my T2
to the PC. 

The problem is now when I disconnect the T2 /dev/rfcomm0 is destroyed so
I cannot reconnect without recreating it.

Phil


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Message-ID: <481A648B.9020501@magtech.com.au>
Date: Fri, 02 May 2008 10:47:07 +1000
From: Aras Vaichas <arasv@magtech.com.au>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48196709.9030104@magtech.com.au> <481993DB.20608@powercraft.nl>
In-Reply-To: <481993DB.20608@powercraft.nl>
Subject: Re: [Bluez-users] Bluez + dbus for ARM solutions?
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

Jelle de Jong wrote:
> Aras Vaichas wrote:
>   
>> Hi,
>>
>> can someone point me to where I can find scripts/patches that will help
>> me build ARM cross-compiled versions of Bluez + dbus for ARM?
>>
>> Is there a well know set of dbus+bluez versions that are known to work
>> for cross-compiling, or does everyone just hack the configure files
>> until it works?
>>
>> I'm currently stuck in dependency hell trying to get dbus to
>> cross-compile. So far I've got expat, bluez-libs,  and libusb compiled.
>>
>> I saw that someone recommended Scratchbox (for dbus) but I'd rather not
>> do that because I am able to cross-compile every single other library
>> and application for my distribution (including Python) without requiring
>> a method like Scratchbox.
>>
>> Aras Vaichas
>>     
>
> Have you looked at the Debian arm packages? I believe Debian has almost 
> all packages compiled for arm. But I may be missing something...
>   
Yes I did start by going through the Debian website and downloading all
the packages that looked they were required for Bluetooth networking.

e.g. bluez-utils_3.7-1_arm.deb, dbus_1.0.2-1_arm.deb,
hal_0.5.8.1-9_arm.deb, libbluetooth2_3.7-1_arm.deb,
libc6_2.3.6.ds1-13etch5_arm.deb, ppp_2.4.4rel-8_arm.deb,
libdbus-1-3_1.0.2-1_arm.deb, libexpat1_1.95.8-3.4_arm.deb,
libusb-0.1-4_0.1.12-5_arm.deb, lsb-base_3.1-23.2etch1_all.deb

We run a minimal, fully customised embedded Linux system with limited
space. The problem is that the Debian ARM packages are  compiled with
many options that we don't need. We currently don't run dbus or hal
because we just haven't needed them.

The dependency list isn't too bad for all those packages:

        /lib/ld-linux.so.2 (0x40000000)
        libX11.so.6 => not found
        libbluetooth.so.2 => not found
        libc.so.6 => /lib/libc.so.6 (0x4001e000)
        libdbus-1.so.3 => not found
        libdbus-glib-1.so.2 => not found
        libexpat.so.1 => not found
        libglib-2.0.so.0 => not found
        libgobject-2.0.so.0 => not found
        libhal-storage.so.1 => not found
        libhal.so.1 => not found
        libm.so.6 => /lib/libm.so.6 (0x4001e000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x4014e000)
        librt.so.1 => /lib/librt.so.1 (0x4001e000)
        libusb-0.1.so.4 => not found
        libvolume_id.so.0 => not found

Then I saw that dbus required X11 ... so I started cross-compiling
everything from source and that's about the time that the pain began.

I can probably use the Debian package method for development purposes,
but ideally I'd require custom configured versions of these applications.

Aras

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

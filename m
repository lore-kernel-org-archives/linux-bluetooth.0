Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FF9C42.1090604@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trying to compile for axis but Bluetooth library
 not found
References: <41FE85A0.2040709@ieee.org>	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie>	 <1107254209.9652.0.camel@pegasus>  <41FF8FE0.8010204@gmx.ch> <1107268938.9652.34.camel@pegasus>
In-Reply-To: <1107268938.9652.34.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------060102060108020601040100"
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
Date: Tue, 01 Feb 2005 16:12:02 +0100

This is a multi-part message in MIME format.
--------------060102060108020601040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> looks nice so far to me, but I like to have somekind of generic cross
> compilation instruction.

unfortunately I've only an arm machine here and have no experience with 
other platforms.
maybee the guy with the axis developer board is willing to add his knowledge.

> I also prefer using DESTDIR for install, so
> that you can make an installation for /usr without overwriting your
> local files.

I made it a little bit more generic and used DESTDIR as term in the 
description. If someone could give feedback about the toolchain, the 
mini-howto would become really generic...


kind regards
Marco

--------------060102060108020601040100
Content-Type: text/plain;
 name="bluezCrossCompiling-miniHowto"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluezCrossCompiling-miniHowto"

This document shows how to cross-compile bluez for an arm-processor on an i686 processor.
It can be used as starting point if you have to cross-compile bluez yourself.

date/version: 01 Feb. 2005, v0.1.2
author:       Marco Trudel <mtrudel@gmx.ch>

If you need help, please use the bluez-user list.

------------------------------------------------------------

This document assumes you have the toolchain installed in /usr/local/arm.
Version 2.95.3 is used in this description.
That means a directory called "/usr/local/arm/2.95.3/arm-linux" exists.
Bluez will be installed into /opt/bluez (feel free to choose another location).

Ensure that the crosscompile binaries are in $PATH.
For example, do: export PATH="$PATH:/usr/local/arm/2.95.3/bin"

Please note: The term DESTDIR will be used in the following commands.
             This is the directory where bluez will be installed to.
	     Replace it, for example, with /opt/bluez or /tmp/bluez.

########## 1. compile bluez-libs ##########
- extract bluez-libs and change into the directory
- configure the makefiles for cross-compiling:
        ./configure --build=i686-pc-linux-gnu  \
                    --host=arm-linux           \
                    --prefix=DESTDIR           \
                    [--sysconfdir=DESTDIR/etc]

- Explanation of the switches:
        --build        The build platform (as example a i686).
	--host         The target platform (as example arm-linux).
	               Please change it to match your target-system.
	--prefix       Where bluez will be installed to.
	--sysconfdir   Where bluez will expect etc.
	               You can remove this switch if /etc is ok for you.

- Check the output. Some interesting lines:
        checking for arm-linux-gcc... arm-linux-gcc
        checking whether the C compiler works... yes
        checking whether we are cross compiling... yes

- run "make", "make install"

########## 2. compile bluez-utils ##########
- extract bluez-utils and change into the directory
- configure the makefiles for cross-compiling. run:
        ./configure --build=i686-pc-linux-gnu  \
                    --host=arm-linux           \
                    --prefix=DESTDIR           \
                    [--sysconfdir=DESTDIR/etc  \]
                    LDFLAGS=-LDESTDIR/lib

- LDFLAGS is where the bluez lib will be searched for.
(Please note that -L is needed. For example LDFLAGS=-L/opt/bluez/lib)

- run "make" and "make install"


######### 3. final steps, tests ##########
Please note: This mini-howto assumes you have a bluetooth enabled kernel.
If you haven't already, install it now.

Depending on your setup, you might be interested in every kb
of diskspace to save. With -s stripping and removing of unnecessary
files, it's possible to save ~350kb...

copy DESTDIR to your target platform.

on your target platform:
- add "DESTDIR/lib" to /etc/ld.so.conf and, run "ldconfig"
- run "./hcid -n" in DESTDIR/sbin
Check the output.
If everything works well, abort hcid and start it withhout "-n".

- "DESTDIR/bin/hcitool dev" should show you your devices
- "DESTDIR/bin/hcitool scan" perform an inquiry scan
--------------060102060108020601040100--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FF8FE0.8010204@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trying to compile for axis but Bluetooth library
 not found
References: <41FE85A0.2040709@ieee.org>	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie> <1107254209.9652.0.camel@pegasus>
In-Reply-To: <1107254209.9652.0.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------090307060300010402020407"
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
Date: Tue, 01 Feb 2005 15:19:12 +0100

This is a multi-part message in MIME format.
--------------090307060300010402020407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel

Is this ok?
Any improvement suggestions? Anyone?


kind regards
Marco


Marcel Holtmann wrote:
> Hi,
> 
> 
>>Thanks Erwin. I also used --libdir=  too and I can compile the utils. 
>>(Haven't tested them yet - trying to get the kernel up and running).
>>
>>I wasn't sure about using --host as the script gave some kind of error 
>>about not using it.
> 
> 
> may someone write a small BlueZ cross-compilation howto that I can add
> to the website?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 

--------------090307060300010402020407
Content-Type: text/plain;
 name="bluezCrossCompiling-miniHowto"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluezCrossCompiling-miniHowto"

This document shows how to cross-compile bluez for an arm-processor on an i686 processor.
It can be used as starting point if you have to cross-compile bluez yourself.

date/version: 01 Feb. 2005, v0.1
author:       Marco Trudel <mtrudel@gmx.ch>

If you need help, please use the bluez-user list.

------------------------------------------------------------

This document assumes you have the toolchain installed in /usr/local/arm.
Version 2.95.3 is used in this description.
That means a directory called "/usr/local/arm/2.95.3/arm-linux" exists.
Bluez will be installed into /opt/bluez (feel free to choose another location).

Ensure that the crosscompile binaries are in $PATH.
For example, do: export PATH="$PATH:/usr/local/arm/2.95.3/bin"

########## 1. compile bluez-libs ##########
- extract bluez-libs and change into the directory
- configure the makefiles for cross-compiling. run:
        ./configure --build=i686-pc-linux-gnu    \
                    --host=arm-linux             \
                    --sysconfdir=/opt/bluez/etc  \
                    --prefix=/opt/bluez

- Check the output. Some interesting lines:
        checking for arm-linux-gcc... arm-linux-gcc
        checking whether the C compiler works... yes
        checking whether we are cross compiling... yes
- run "make", "make install"

The bluez libs are now intalled in /opt/bluez.
At this point, compiling the bluez-utils still fails because it doesn't
find the library (--with-bluez=/opt/bluez dosn't work for me, the error is:
/usr/local/arm/2.95.3/arm-linux/bin/ld: cannot find -lbluetooth)
To make it work, we install the bluez-libs in the arm-linux directory.
To keep that directory clean, we'll remove bluez from it later again.
If someone knows why --with-bluez doesn't work, please inform me.

Run:
        ./configure --build=i686-pc-linux-gnu    \
                    --host=arm-linux             \
                    --sysconfdir=/opt/bluez/etc  \
                    --prefix=/usr/local/arm/2.95.3/arm-linux
        make install # do not run "make"


########## 2. compile bluez-utils ##########
- extract bluez-utils and change into the directory
- configure the makefiles for cross-compiling. run:
        ./configure --build=i686-pc-linux-gnu   \
                    --host=arm-linux            \
                    --sysconfdir=/opt/bluez/etc \
                    --prefix=/opt/bluez
- run "make" and "make install"


########## 3. clean up ##########
As promised in the first step, we keep our arm-linux directory clean.
So change back into the bluez-libs folder and run:
make uninstall


######### 4. final steps, tests ##########
Please note: This mini-howto assumes you have a bluetooth enabled kernel.
If you haven't already, install it now.

Depending on your setup, you might be interested in every kb
of diskspace to save. With -s stripping and removing of unnecessary
files, it's possible to save ~350kb...

- copy /opt/bluez to your target platform.
- add "/opt/bluez/lib" to /etc/ld.so.conf and, run "ldconfig"
- run "./hcid -n" in /opt/bluez/sbin
Check the output.
If everything works well, abort hcid and start it withhout "-n".

- "/opt/bluez/bin/hcitool dev" should show you your devices
- "/opt/bluez/bin/hcitool scan" perform an inquiry scan
--------------090307060300010402020407--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trying to compile for axis but Bluetooth library
	not found
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FE85A0.2040709@ieee.org>
References: <41FE85A0.2040709@ieee.org>
Content-Type: text/plain
Message-Id: <1107204712.15769.70.camel@justakiss>
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
Date: Mon, 31 Jan 2005 21:51:52 +0100

Am Mon, den 31.01.2005 schrieb joe sloan um 20:23:
> Hi,
> 
> I have compiled bluez-libs-2.14 but having problems with bluez-utils-2.14.
> 
> I'm working on a PC with SUSE 9.1, and the target is devboard_82 with 
> linux-2.4.26.
> 
> I've tried almost every option at this stage and I keep getting the 
> error related to /lib/libc.so.6 I cannot figure out where it is getting 
> this from - my guess is that it should be pointing to 
> ../../target/cris-axis-linux-gnu/lib/libc.so.6  but cannot.
> 
> I'd appreciate some help or pointers with this (having searched the web 
> and this newgroup - and tried loads of combinations of commands).
> 
> thanks
> 
> Joe
...
> 
> cd bluez-libs-2.14/
> linux:/axis/devboard_82/apps/bluez-libs-2.14 # ./configure CC="gcc-cris 
> -mlinux"  LD="cris-ld"   --target=cris-axis-linux --host=i686-pc-linux 
> --prefix=/usr

Hi,
it seems that your options for configure are wrong for cross
compilation. --host specifies the system where the package will run.
This should be cris-axis-linux in your case, I guess.

As a general hint for cross compiling:
* Set CC,CFLAGS and LDFLAGS that you need for cross compiling in the
environment.
* use "./configure --host=<your target architecture>" (and special
options that are required, but don't use --target or --build !!)

For bluez-utils-2.10, I had to specify --with-bluez=.. and --with-usb=..
with the path were the bluez-libs includes were installed.

Hope that helps
Erwin






-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

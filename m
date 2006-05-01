Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44560F4C.6010709@ens.fr>
From: Giuseppe Castagna <Giuseppe.Castagna@ens.fr>
MIME-Version: 1.0
To: Giuseppe Castagna <Giuseppe.Castagna@ens.fr>
Cc: claudio.takahasi@indt.org.br, bluez-devel@lists.sourceforge.net
References: <445501FC.9070103@ens.fr>
In-Reply-To: <445501FC.9070103@ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re: gbluezconf-00.10
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 01 May 2006 15:38:20 +0200

Giuseppe Castagna wrote:
 >
 > Any suggestion? Should I use the cvs version of bluez-utils?
 >

Indeed, I should have tried this before writing. I installed cvs version of 
bluez-libs and bluez-utils and now gbluezconf partially works.

Advanced Configuration and Search Devices no longer are greyed, while
"Set up bluetooth device" still is (is it normal?). When I select search devices 
I obtain the following error message.

[_dbus_send_inquiry_request] search.c:1200: [DBUS] reply 
error:(org.bluez.Error.NotImplemented,Not implemented)

Looking at the code I have seen that it calls DiscoverDevices. So I tried to 
play around with it but I always obtain a Null result.

BTW

  bluez/utils/hcid/dbus-test DiscoverDevices

does not work since the entry for  DiscoverDevices was forgotten. Any suggestion 
on how to have seach working?

Thanks in advance



Giuseppe Castagna wrote:
> Hi,
>    I successfully compiled gbluezconf-00.10: I just had to change
> 
> $ACLOCAL -I m4 || exit 1
> 
> into
> 
> $ACLOCAL -I ./m4 || exit 1
> 
> to do it. I installed and launched it but in the submenues all option 
> are greyed  apart from About Help Quit. My bluetooth system is working 
> (in this right moment I am writing this mail by using a bluetooth mouse, 
> connected by the "old way"  hidd --connect). When launching gbluezconf 
> on the console the follwoing messages are displayed
> 
> [beppe@mirto tmp]$ gbluezconf
> [stock_icons_init] stock-icons.c:57: Loading:gbluezconf-tray-icon.png
> [stock_icons_init] stock-icons.c:57: Loading:gbluezconf-inactive.png
> [stock_icons_init] stock-icons.c:57: Loading:gbluezconf-data.png
> [_device_default_update] shell.c:534: reply 
> error:(org.bluez.Error,Method not found)
> 
> 
> 
> I running a custom kernel 2.6.17-rc3 on a Fedora 5 installation and use 
> the following libraries:
> 
> bluez-pin-0.30-2
> bluez-utils-2.25-4
> bluez-libs-devel-2.25-1
> bluez-libs-2.25-1
> 
> Any suggestion? Should I use the cvs version of bluez-utils? Thanks in 
> advance!
> 
> ---Beppe---
> 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

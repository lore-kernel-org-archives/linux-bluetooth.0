Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4443519A.4050302@runbox.com>
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Installing Bluetooth-alsa ./configure fails
References: <200604170852.24545.tuckernj@ntlworld.com>
In-Reply-To: <200604170852.24545.tuckernj@ntlworld.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 17 Apr 2006 09:28:10 +0100

Neil Tucker wrote:
> Hi
>
> I'm attempting to install Bluetooth-alsa on my Fedora Core 5 machine.  I'm 
> reasonablly good with using linux but have little experience compiling 
> packages but have made a few custom kernels before by following the howto.
>
> It is a 2.6.* kernel. The kernel source package is installed and linked 
> to  /usr/src/linux
>
> The ./configure fails because it can't find the bluetooth.h header files see 
> below.  Here are the steps I take:
>
> 	#yum install bluez-libs bluez-pin bluez-utils bluez-hcidump bluez-utils-cup
>
> 	#yum install alsa-tools alsa-lib alsa-utils alsa-lib-devel
>
> 	#yum install automake
>
> 	$ cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa log
> 	$ cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
> 	
> 	$ cd btsco
>
> 	$ ./bootstrap
> 	$ ./configure
> 		.
> 		.
> 		.	
> 		checking bluetooth/bluetooth.h usability... no
> 		checking bluetooth/bluetooth.h presence... no
> 		checking for bluetooth/bluetooth.h... no
> 		configure: error: Bluetooth header files not found
>
>
> Can body help me please? 
>
>
>   
Install bluez-libs-devel.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

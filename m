Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No device listing under hciconfig on Lifebook
	E8020
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <pan.2006.02.09.19.37.28.802680@wever.org>
References: <pan.2006.02.09.19.37.28.802680@wever.org>
Content-Type: text/plain
Message-Id: <1139533006.17280.35.camel@localhost>
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
Date: Fri, 10 Feb 2006 01:56:46 +0100

Hi Mick,

> I cannot get any device listed using hciconfig.
> Trying both the internal bluetooth to the Fujitsu-Siemens Lifebook E8020
> 
> cat /proc/bus/usb/devices | grep -e^[TPD] | grep -e Cls=e0 -B1 -A1
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=044e ProdID=3001 Rev=11.68
> 
> 
> And a external Bluetooth USB dongle:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a12 ProdID=0001 Rev= 5.25
> 
> 
> I'm running Gentoo GNU/Linux: 2.6.14-gentoo-r5
> Using bluez-libs-2.25 and bluez-utils-2.25
> 
> Most frustrating is I cannot find any errors anywhere (dmesg).

show us the complete devices entry for these two adapters. And make sure
that hci_usb is loaded.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

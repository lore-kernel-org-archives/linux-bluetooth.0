Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Cellink BTA-3120 for Kernel 2.6.15
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060116163025.0E1411DE931@mrelay2.st2.lyceu.net>
References: <20060116163025.0E1411DE931@mrelay2.st2.lyceu.net>
Content-Type: text/plain
Message-Id: <1137495785.21629.4.camel@localhost>
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
Date: Tue, 17 Jan 2006 12:03:05 +0100

Hi Franz,

> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0c10 ProdID=0000 Rev=20.05
> S:  Manufacturer=Bluetooth Device
> S:  Product=Bluetooth Device
> S:  SerialNumber=538815940A00

you don't have to change the device list inside the driver. The D: line
is correct and if the USB subsystem doesn't load the hci_usb driver,
complain on the USB mailing list.

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

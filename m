Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <adf2d65c0611130332h65523aa1ycf17bce10e957f8e@mail.gmail.com>
References: <adf2d65c0611130332h65523aa1ycf17bce10e957f8e@mail.gmail.com>
Date: Tue, 14 Nov 2006 07:19:38 +0100
Message-Id: <1163485178.22566.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Targus ACB20EU: Scan times out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Arthur,

> Scanning for other devices with the Targus ACB20EU USB dongle (a 
> bluetooth 2.0 adapter with EDR support according to the packaging) 
> always times out. It doesn't help to run hcid or hciconfig hci0 up 
> beforehand. This is how it looks like:
> 
> # hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> 
> Running hcidump -X -V at the same time only yields this output:
> 
> # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.32
> device: hci0 snap_len: 1028 filter: 0xffffffff 
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>      lap 0x9e8b33 len 8 num 0
>  > HCI Event: Command Complete (0x0e) plen 4
>      Inquiry (0x01|0x0001) ncmd 1
>      0000: 0c

this is a broken chip anyway. The failure of HCI_Inquiry must be
answered with a HCI_Command_Status event and not a HCI_Command_Complete
event.

Is this another Broadcom based dongle?

Try loading the hci_usb with "reset=1" and post the content
of /proc/bus/usb/devices.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

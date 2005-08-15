Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <009201c5a16a$2c19f0b0$b604a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
References: <E64BAD5A8AD46740828069A678D9DD73011A8D@netbe01.net.unimis>
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
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
Date: Mon, 15 Aug 2005 12:52:57 +0530

Hi Al,
I recently ported bluez stack in a embedded linux running 2.4.18 kernel.
First I downloaded the MH patch from  http://www.holtmann.org/linux/kernel/. 
and
applied it. Now both statically compiled driver as well as modules are 
working correctly.
You can also try finding an appropriate patch and patch it with your kernel. 
But what is
surprising for me is, though your kernel is 2.4.21 and you are not able to 
find the options in
make menuconfig.  I guess something  is messed up in your package.

Can you find "hci_usb_init" in your System.map? Is it integrated correctly?
regards
durai
----- Original Message ----- 
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Sent: Monday, August 15, 2005 11:43 AM
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux


Hi,

     "hciconfig -a hci0" results the same.
-------------------------------------------------
/> new USB device :801aaa04-174d60
hub.c: new USB device 1, assigned address 2
usb.c: USB device 2 (vend/prod 0x1131/0x1001) is not claimed by any active 
driv.
/>
/> hciconfig -a hci0

Can't get device info: No such device
pid 9: failed 256
/>

---------------------------------------------------
      I think bluetooth drivers are not integrated to kernel correctly. 
hci_usb_init() in hci_usb.c is not run since I can't read the printout in 
embedded linux while the printout can be read in PC RH9 linux.

int hci_usb_init(void)
{
int err;

BT_INFO("BlueZ HCI USB driver ver %s Copyright (C) 2000,2001 Qualcomm Inc",
VERSION);
BT_INFO("Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>");

if ((err = usb_register(&hci_usb_driver)) < 0)
BT_ERR("Failed to register HCI USB driver");

return err;
}

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net on behalf of Paul Webster
Sent: Mon 8/15/2005 1:38 PM
To: bluez-devel@lists.sourceforge.net
Cc:
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
>      You are right about BlueZ was not initilized. After I force define 
> MODULE in
> af_bluetooth.c , creating bluetooth socket using hciconfig is OK. But 
> command "hciconfig
> -a" still can't read the bluetooth USB dongle information.

What about "hciconfig -a hci0"?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

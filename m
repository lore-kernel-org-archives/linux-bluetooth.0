Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] OUT transaction: 3 bytes (03 10 00) problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d6db2b820602150328l714b3561qe3b63f8823612143@mail.gmail.com>
References: <d6db2b820602150328l714b3561qe3b63f8823612143@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140010169.26072.52.camel@localhost>
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
Date: Wed, 15 Feb 2006 14:29:29 +0100

Hi Michael,

> We would like to setup BT communication on embedded MIPS-processor
> Broadcom
> card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).
> Kernel contained USB support, HID support and BlueTooth support (on
> all
> layers).
> On this card we're using USB-PCI host-controller of Philips
> (ISP1562ES1).
> We are using Bluez-2.24 library and utils. We also use the library for
> userspace-kernelspace USB translation (libusb-0.1.so.4.4.3 ).
> 
> We are using CSR based BT dongle with the following description:
> >T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0>
> >D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> >P:  Vendor=0a12 ProdID=0001 Rev=11.20
> (as we saw in the supported products list, it is supported.)
>  
> When we are connecting the BT dongle to Broadcom (2.4) the Broadcom
> recognizes it on the USB bus but fails attempting to retrieve from the
> dongle BD address.
> We tracked all USB urbs in case of Linux 2.6 on desktop vs Linux 2.4
> on Broadcom card.
> USB transactions are identical (except for device number setting) up
> to the point where an OUT transaction is sent with the following data
> (recorded using Ellisys):
> 
> SETUP transaction:     8 bytes (00 05 02 00 00 00 00 00)
> SETUP transaction:     8 bytes (80 06 00 01 00 00 08 00)
> IN transaction:        8 bytes (12 01 10 01 E0 01 01 40)
> SETUP transaction:     8 bytes (80 06 00 01 00 00 12 00)
> IN transaction:        18 bytes (12 01 10 01 E0 01 01 40 12 0A 01 00
> 20 11 00 00 00 01)
> SETUP transaction:     8 bytes (80 06 00 02 00 00 08 00)
> IN transaction:        8 bytes (09 02 B1 00 02 01 00 C0)
> SETUP transaction:     8 bytes (80 06 00 02 00 00 B1 00)
> IN transaction:        64 bytes (09 02 B1 00 02 01 00 C0 00 09 04 00
> 00 03 E0 01 01 00 07 05 81 03 10 00 01 07 05 02 02 40  00 01 07
> 05 ...)
> IN transaction:        64 bytes (01 01 02 E0 01 01 00 07 05 03 01 09
> 00 01 07 05 83 01 09 00 01 09 04 01 02 02 E0 01 01 00 07 05 03 01 ...)
> IN transaction:        49 bytes (19 00 01 09 04 01 04 02 E0 01 01 00
> 07 05 03 01 21 00 01 07 05 83 01 21 00 01 09 04 01 05 02 E0 01 01 ...)
> SETUP transaction:     8 bytes (00 09 01 00 00 00 00 00)
> SETUP transaction:     8 bytes (01 0B 02 00 01 00 00 00)
> IN transaction:        6 bytes (0F 04 00 01 00 00)
> SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
> OUT transaction:    3 bytes (03 10 00)
> ----------this was the same as in broadcom+2.4.20
> 
> SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
> OUT transaction:    3 bytes (05 10 00)
> IN transaction:        14 bytes(0E 0C 01 03 10 00 FF FF 0F 00 00 00 00
> 00)
> SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
> OUT transaction:    3 bytes (09 10 00)
> IN transaction:        13 bytes(0E 0B 01 05 10 00 C0 00 40 08 00 08
> 00)
> IN transaction:        12 bytes(0E 0A 01 09 10 00 FE 70 10 DD 09 00)
> SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
> OUT transaction:    3 bytes (25 0C 00)
> SETUP transaction:     8 bytes (20 00 00 00 00 00 05 00)
> OUT transaction:    5 bytes (05 0C 02 00 C0)
> IN transaction:        8 bytes (0E 06 01 25 0C 00 60 00)
> SETUP transaction:     8 bytes (20 00 00 00 00 00 05 00)
> OUT transaction:    5 bytes (18 0C 02 00 80)
> IN transaction:        6 bytes (0E 04 01 05 0C 12)
> ...
> 
> 
> How to change the code / use a patch to solve this problem in 2.4
> (broadcom)?
> Can someone please explain us why 2.4 does not continuesending SETUP,
> OUT etc. following sending OUT transaction (3 bytes): 03 10 00 ?
> Where in the code the mechaninsm is defied?
> Where in the USB/BT specification we can find the meaning of "OUT
> transaction (3 bytes): 03 10 00" and other transactions.

actually the USB subsystem of 2.4 and 2.6 Linux kernels are totally
different. You need to ask the USB guys about any specific things, but
the bottom line is still that 2.4 is the old kernel. You shouldn't spent
any effort in fixing USB bugs in a 2.4 kernel. The better approach is to
get a decent 2.6 kernel working.

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

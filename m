Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A87@netbe01.net.unimis>
Message-ID: <Pine.LNX.4.33.0508121055510.3858-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 12 Aug 2005 11:01:55 +0200 (CEST)


Hi AL,

first question : what kernel version you are using ??

Second: why you change the Makefile ??? Simply do a make menuconfig or
what ever you prefer and configure that Bluetooth is compiled build in and
not as a module.

Make sure you have basic networking support enabled for your kernel.

I can't see that you compiled in the bluetooth USB driver. So this is
required when you use a USB adapter. But you don't need the *_cs drivers.

Why do you think an embedded system can't support modules ????

Ciao,

Peter


On Fri, 12 Aug 2005, Al wrote:

> Hi, there:
>
>      I'm trying to port BlueZ on embedded linux. The followings are
> what I've done so far:
>
> ======== For Kernel part =============
>
> The embedded linux cannot load modules so I need to make BlueZ as part of kernel itself.
>
> 1. Change Makefile in linux/drivers/bluetooth
>                                                                                                                                                -------------------------------------
> O_TARGET        := bluetooth.o
>                                                                                                                                                list-multi      := hci_uart.o
>                                                                                                                                                obj-y += hci_usb.o
> obj-y += hci_vhci.o
>                                                                                                                                                obj-y += hci_uart.o
> uart-y := hci_ldisc.o
> uart-y += hci_h4.o
>                                                                                                                                                obj-y += dtl1_cs.o
> obj-y += bt3c_cs.o
> obj-y += bluecard_cs.o
>                                                                                                                                                include $(TOPDIR)/Rules.make
>                                                                                                                                                hci_uart.o: $(uart-y)
>         $(LD) -r -o $@ $(uart-y)
> --------------------------------------
> 2. Add line below in Makefile in linux/drivers
>     subdir-y += bluetooth
>
> 3. Change Makefile in /linux/net/bluetooth
> --------------------------------------------
> O_TARGET := bluetooth.o
>
> obj-y    := af_bluetooth.o hci_core.o hci_sock.o lib.o syms.o hci_conn.o hci_event.o l2cap.o sco.o
>
> include $(TOPDIR)/Rules.make
> ------------------------------------------
>
> 4. Add lines Makefile in linux/net
>     subdir-y += bluetooth
>     obj-y += bluetooth/bluetooth.o
>
> ========= For User Space (Utility) part===========
> Use embedded compilier to make  "hciconfig" and copy it to embedded romdisk.
>
> A CSR USB dongle is used. When I boot up the device and execute
> hciconfig.
>
> It prints errors when trying to create bluetooth socket:
>
> "Can't open HCI socket.: Address family not supported by protocol"
>
> if ((ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0)
> {
> 		perror("Can't open HCI socket.");
> 		exit(1);
> }
>
> It seems like BlueZ is not integrated into kernel, but the object files in linux/drivers/bluetooth and linux/net/bluetooth are created without errors.
>
> Does anyone have previous experience to port BlueZ on embeded linux and not using as modules?
> Any advice/comment is appriciated.
>
> Thanks for the helps.
>
> Al
>
>
>
>
>
>
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

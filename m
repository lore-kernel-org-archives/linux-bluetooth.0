Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A87@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Porting BlueZ on embedded uClinux
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
Date: Fri, 12 Aug 2005 16:39:25 +0800

Hi, there:

     I'm trying to port BlueZ on embedded linux. The followings are
what I've done so far:

=3D=3D=3D=3D=3D=3D=3D=3D For Kernel part =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The embedded linux cannot load modules so I need to make BlueZ as part =
of kernel itself.

1. Change Makefile in linux/drivers/bluetooth
                                                                         =
                                                                      =
-------------------------------------
O_TARGET        :=3D bluetooth.o
                                                                         =
                                                                      =
list-multi      :=3D hci_uart.o
                                                                         =
                                                                      =
obj-y +=3D hci_usb.o
obj-y +=3D hci_vhci.o
                                                                         =
                                                                      =
obj-y +=3D hci_uart.o
uart-y :=3D hci_ldisc.o
uart-y +=3D hci_h4.o
                                                                         =
                                                                      =
obj-y +=3D dtl1_cs.o
obj-y +=3D bt3c_cs.o
obj-y +=3D bluecard_cs.o
                                                                         =
                                                                      =
include $(TOPDIR)/Rules.make
                                                                         =
                                                                      =
hci_uart.o: $(uart-y)
        $(LD) -r -o $@ $(uart-y)
--------------------------------------
2. Add line below in Makefile in linux/drivers
    subdir-y +=3D bluetooth

3. Change Makefile in /linux/net/bluetooth
--------------------------------------------
O_TARGET :=3D bluetooth.o
                                                                         =
      =20
obj-y    :=3D af_bluetooth.o hci_core.o hci_sock.o lib.o syms.o =
hci_conn.o hci_event.o l2cap.o sco.o
                                                                         =
                                                                         =
             =20
include $(TOPDIR)/Rules.make
------------------------------------------

4. Add lines Makefile in linux/net
    subdir-y +=3D bluetooth
    obj-y +=3D bluetooth/bluetooth.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D For User Space (Utility) =
part=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Use embedded compilier to make  "hciconfig" and copy it to embedded =
romdisk.

A CSR USB dongle is used. When I boot up the device and execute
hciconfig.

It prints errors when trying to create bluetooth socket:

"Can't open HCI socket.: Address family not supported by protocol"

if ((ctl =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0)=20
{=09
		perror("Can't open HCI socket.");
		exit(1);
}

It seems like BlueZ is not integrated into kernel, but the object files =
in linux/drivers/bluetooth and linux/net/bluetooth are created without =
errors.

Does anyone have previous experience to port BlueZ on embeded linux and =
not using as modules?
Any advice/comment is appriciated.

Thanks for the helps.

Al









-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

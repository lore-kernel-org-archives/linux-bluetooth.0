Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 8 Apr 2009 18:09:59 +0530
Message-ID: <affb55530904080539s4d3ffdbbt92534027cda7c730@mail.gmail.com>
Subject: Bluetooth dongle
From: kewal <kewal.deshpande@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am not able to compile the BlueZ  files which is present in the
bluetooth folder in drivers.
this is the config.in file

mainmenu_option next_comment
comment 'Bluetooth device drivers'

dep_tristate 'HCI USB driver' CONFIG_BLUEZ_HCIUSB $CONFIG_BLUEZ $CONFIG_USB
if [ "$CONFIG_BLUEZ_HCIUSB" != "n" ]; then
   bool '  USB zero packet support'  CONFIG_BLUEZ_USB_ZERO_PACKET
fi

dep_tristate 'HCI UART driver' CONFIG_BLUEZ_HCIUART $CONFIG_BLUEZ
if [ "$CONFIG_BLUEZ_HCIUART" != "n" ]; then
   bool '  UART (H4) protocol support' CONFIG_BLUEZ_HCIUART_H4
fi

dep_tristate 'HCI DTL1 (PC Card) driver' CONFIG_BLUEZ_HCIDTL1
$CONFIG_PCMCIA $CONFIG_BLUEZ

dep_tristate 'HCI BT3C (PC Card) driver' CONFIG_BLUEZ_HCIBT3C
$CONFIG_PCMCIA $CONFIG_BLUEZ

dep_tristate 'HCI BlueCard (PC Card) driver' CONFIG_BLUEZ_HCIBLUECARD
$CONFIG_PCMCIA $CONFIG_BLUEZ

dep_tristate 'HCI VHCI (Virtual HCI device) driver'
CONFIG_BLUEZ_HCIVHCI $CONFIG_BLUEZ

endmenu



and this is the make file,
#
# Makefile for Bluetooth HCI device drivers.
#

O_TARGET	:= bluetooth.o

list-multi	:= hci_uart.o

obj-$(CONFIG_BLUEZ_HCIUSB)	+= hci_usb.o
obj-$(CONFIG_BLUEZ_HCIVHCI)	+= hci_vhci.o

obj-$(CONFIG_BLUEZ_HCIUART)	+= hci_uart.o
uart-y				:= hci_ldisc.o
uart-$(CONFIG_BLUEZ_HCIUART_H4)	+= hci_h4.o

obj-$(CONFIG_BLUEZ_HCIDTL1)	+= dtl1_cs.o
obj-$(CONFIG_BLUEZ_HCIBT3C)	+= bt3c_cs.o
obj-$(CONFIG_BLUEZ_HCIBLUECARD)	+= bluecard_cs.o

include $(TOPDIR)/Rules.make

hci_uart.o: $(uart-y)
	$(LD) -r -o $@ $(uart-y)


However the experimental stack by axis is getting compiled which is in
the USB folder.


-- 
Kewal

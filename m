Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gene Imes <ebi7@ozob.net>
To: bluez <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FF9CA56.1060205@Fampeeters.com>
References: <3FF9CA56.1060205@Fampeeters.com>
Content-Type: text/plain
Message-Id: <1073341923.6567.20.camel@tr1a.ozob.net>
Mime-Version: 1.0
Subject: [Bluez-users] Socket CF card problems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 05 Jan 2004 16:32:04 -0600

I apologize if this is too lengthy, but I need some help.

I am running a 2.6.0 kernel and I am trying to get a Socket CF card
running.

root@tr1a:~# ver
Linux version 2.6.1-rc1-mm1 (root@tr1a) (gcc version 3.3.2 20031218
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #5 Mon Jan 5 10:54:39 CST 2004

cardctl shows:

root@tr1a:~# cardctl ident
Socket 0:
  product info: "Socket", "CF+ Personal Network Card Rev 2.5"
  manfid: 0x0104, 0x0096
  function: 2 (serial)

According to http://www.holtmann.org/linux/bluetooth/devices.html this
card is 'working'.

My /usr/src/linux/.config file looks like this:

...
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
                                                                                                                             
#
# Bluetooth device drivers
#
# CONFIG_BT_HCIUSB is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

...
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

When I insert the Socket card (which is of course itself inserted in a
pcmcia adapter) I get this:

root@tr1a:~# lsmod
Module                  Size  Used by
serial_cs               9352  1
8250                   21280  3 serial_cs

I guess this is proper.

And then:

root@tr1a:~# dmesg
...
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 5) is a 16C950/954

So I issue:

root@tr1a:/boot# hciattach /dev/ttyS0 any 115200

the bluetooth modules load:

root@tr1a:~# lsmod
Module                  Size  Used by
hci_uart               16848  0
bluetooth              49508  1 hci_uart
serial_cs               9352  1
8250                   21280  3 serial_cs
...
serial_core            23168  2 8250,hsfserial

root@tr1a:~# dmesg

Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type a5
h4_recv: Unknown HCI packet type e7
h4_recv: Unknown HCI packet type e0
h4_recv: Unknown HCI packet type ef
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type f0
h4_recv: Unknown HCI packet type e3
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type 8a
h4_recv: Unknown HCI packet type eb
h4_recv: Unknown HCI packet type 2d
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type a5
h4_recv: Unknown HCI packet type e7
h4_recv: Unknown HCI packet type e0
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type 8e
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type 08
h4_recv: Unknown HCI packet type 00
h4_recv: Unknown HCI packet type 38
h4_recv: Unknown HCI packet type a5
h4_recv: Unknown HCI packet type e7
h4_recv: Unknown HCI packet type e0
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type 8a
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type 0c
h4_recv: Unknown HCI packet type 20
h4_recv: Unknown HCI packet type 1a
h4_recv: Unknown HCI packet type f6
h4_recv: Unknown HCI packet type c5
h4_recv: Unknown HCI packet type f0
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type f4
h4_recv: Unknown HCI packet type cf
h4_recv: Unknown HCI packet type 8e
Trying to free nonexistent resource <000003f8-000003ff>

And then:

root@tr1a:~# hciconfig
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:445 acl:0 sco:0 events:0 errors:38
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

And it doesn't work.

Thanks for any help,

-- 
Gene Imes                               www.ozob.net


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811121110i7ab76699mc6ecd32ddd122368@mail.gmail.com>
Date: Wed, 12 Nov 2008 19:10:25 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Problem using CSR module with Bluez
Cc: "Mark Powell" <Mark.Powell@csr.com>,
	"David Vrabel" <david.vrabel@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to use an iMX31PDK bluetooth module (powered by CSR) and I
am getting error to use it with Linux bluez.

Please, follow my steps below:

root@freescale ~$ modprobe hci_uart
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: HCILL protocol initialized

root@freescale ~$ modprobe rfcomm
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8

root@freescale ~$ modprobe mxc_bt
(note: mxc_bt modules just power-on and reset APM6628 module)

root@freescale ~$ hciattach /dev/ttymxc1 bcsp 115200 flow

root@freescale ~$ hciconfig -a
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:15 acl:0 sco:0 events:0 errors:0
        TX bytes:8 acl:0 sco:0 commands:0 errors:0

root@freescale ~$ hciconfig hci0 up

root@freescale ~$ hciconfig -a
hci0:   Type: UART
        BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING
        RX bytes:519 acl:0 sco:0 events:10 errors:0
        TX bytes:214 acl:0 sco:0 commands:11 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'CSR - bc4'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
        Manufacturer: Cambridge Silicon Radio (10)

root@freescale ~$ hcitool scan
Scanning …
root@freescale ~$
(note: it doesn't detect any bluetooth devices around it)


root@freescale ~$ bccmd -t hci psload -r /home/apm6628BT-UART.mx31.psr
Loading PSKEY_LC_COMBO_DISABLE_PIO_MASK ... done
Loading PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE ... done
Loading PSKEY_LC_ENHANCED_POWER_TABLE ... done
Loading PSKEY_UART_BAUDRATE ... done
Loading PSKEY_HOST_INTERFACE ... done
Loading PSKEY_ANA_FREQ ... done
Loading PSKEY_USE_EXTERNAL_CLOCK ... done
Loading PSKEY_CLOCK_REQUEST_ENABLE ... done
Loading PSKEY_CLOCK_REQUEST_FEATURES ... done
Loading PSKEY_PCM_CONFIG32 ... done
root@freescale ~$ bcsp_recv: Error in BCSP hdr checksum

root@freescale ~$ hciconfig -a
hci0:   Type: UART
        BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING
        RX bytes:1317 acl:0 sco:0 events:24 errors:0
        TX bytes:759 acl:0 sco:0 commands:28 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
Can't read local name on hci0: Connection timed out (110)
root@freescale ~$ bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet
bcsp_recv: Short BCSP packet



The i.MX31PDK board uses APM6628 bluetooth module.
I want to use Bluez because already have some programs developed using
this API,
but Freescale is using CSR soft stack on this board. I am using
bluez-lib and bluez-utils 3.26.

I think it is some error in my PSKEY file, maybe this version doesn't
match to firmware
version or some problem on bluez detection.

This is the content of my apm6628BT-UART.mx31.psr file:

// PSKEY_LC_COMBO_DISABLE_PIO_MASK
&0028 = 0200
// PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE
&002a = 0011
// PSKEY_LC_ENHANCED_POWER_TABLE
&0031 = 0400 0000 3f00 4500 e800 0900 0000 3f00 4700 ec00 0f00 0000
3f00 4a00 f000 1600 0000 3f00 4d00 f400 1e00 0000 3f00 5000 f800 2600
0000 3f00 5500 fc00 2e00 0000 3f00 5b00 0000 5000 0000 3f00 6900 0400
// PSKEY_UART_BAUDRATE
&01be = 075f// 460.8 kbaud
// PSKEY_HOST_INTERFACE
&01f9 = 0001// BCSP link
// PSKEY_ANA_FREQ
&01fe = 4e20
//PSKEY_USE_EXTERNAL_CLOCK
&023b = 0001//true
//PSKEY_CLOCK_REQUEST_ENABLE
&0246 = 0003
// PSKEY_CLOCK_REQUEST_FEATURES
&03b6 = 0000
// PSKEY_PCM_CONFIG32
&01b3 = 00c0 0006

Please, can you give me some tips to fix this issue?

Thank you very much,

Alan

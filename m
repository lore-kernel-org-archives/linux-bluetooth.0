Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Chip Wachob <wachobc@gmail.com>
Date: Fri, 10 Feb 2017 13:59:58 -0500
Message-ID: <CADUn+-+v2aYCy2Lw42MWxMPQW0_bdzv5Uim4RuYzwQeu05-21w@mail.gmail.com>
Subject: How to resolve no-connect issue for BT HID Client
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Several other lists that I have posted on have suggested that I post here
for assistance.  I hope this is the right place.

I am attempting to use a PC running Linux with a generic USB BT dongle
appear to be a BT-enabled keyboard.  Basic HID stuff.  In the end this will
be an embedded application but for proof of concept I'd like to be able to
get it to work in a desktop environment.

The hardware is:  Lenovo laptop SL150 using a Kinivo BTD-400 dongle
(Broadcomm chipset from what I can tell).  I'm running Ubuntu 16.04 LTS.  I
have an external keyboard plugged into the laptop to use as my input
device.  This allows me to still have control over the laptop via the
laptop's keyboard.

Software wise:  Bluez 5.37 and GCC 5.4.0.  I know the Eclipse environment
so I've been building in that.  Eclipse version 3.8, using CDT 8.0.2.2 and
GDB Common 7.0.0.2.

I've been searching online for solutions and answers and the closest I've
come is a program which can be found at the link below called HIDClient.
I've renamed the .c file in my application to HID_Test2.  (Code inserted at
the end of the message)

http://anselm.hoffmeister.be/computer/hidclient/index.html.en

There were some initial bumps in the road getting the program to compile,
namely adding in break statements into the large switch/case statements.

At this point I can get the application to run and it gets to the point
where it says that it is ready to connect with an external device.

Before I run any of my software on a fresh re-boot of the machine, I can
get my smartphone (Galaxy S4) to connect via BT.  That connection is stable
until I disconnect it.  I am able to transfer files back and forth between
the two devices without issue.  So I am encouraged that the interface will
work.  That is not the case once I've run the program.  A clean boot copy
of the hciconfig is as follows:

temp@temp-ThinkPad-SL510:~$ sudo hciconfig -a

[sudo] password for temp:

hci0: Type: BR/EDR Bus: USB

BD Address: 5C:F3:70:77:62:B0 ACL MTU: 1021:8 SCO MTU: 64:1

UP RUNNING PSCAN ISCAN

RX bytes:4758 acl:70 sco:0 events:215 errors:0

TX bytes:4818 acl:73 sco:0 commands:151 errors:0

Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

Link policy: RSWITCH SNIFF

Link mode: SLAVE ACCEPT

Name: 'temp-ThinkPad-SL510'

Class: 0x1c010c

Service Classes: Rendering, Capturing, Object Transfer

Device Class: Computer, Laptop

HCI Version: 4.0 (0x6) Revision: 0x1000

LMP Version: 4.0 (0x6) Subversion: 0x220e

Manufacturer: Broadcom Corporation (15)

sdptool output before running the script mentioned below:

temp@temp-ThinkPad-SL510:~/workspace/HID_Test2/Release$ sudo sdptool browse
local

Browsing FF:FF:FF:00:00:00 ...

Service RecHandle: 0x10000

Service Class ID List:

"PnP Information" (0x1200)

Profile Descriptor List:

"PnP Information" (0x1200)

Version: 0x0103


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: Invalid argument

Service Name: Generic Access Profile

Service Provider: BlueZ

Service RecHandle: 0x10001

Service Class ID List:

"Generic Access" (0x1800)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 31

"ATT" (0x0007)

uint16: 0x0001

uint16: 0x0005


Service Name: Generic Attribute Profile

Service Provider: BlueZ

Service RecHandle: 0x10002

Service Class ID List:

"Generic Attribute" (0x1801)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 31

"ATT" (0x0007)

uint16: 0x0006

uint16: 0x0009


Service Name: AVRCP CT

Service RecHandle: 0x10003

Service Class ID List:

"AV Remote" (0x110e)

"AV Remote Controller" (0x110f)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 23

"AVCTP" (0x0017)

uint16: 0x0103

Profile Descriptor List:

"AV Remote" (0x110e)

Version: 0x0106


Service Name: AVRCP TG

Service RecHandle: 0x10004

Service Class ID List:

"AV Remote Target" (0x110c)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 23

"AVCTP" (0x0017)

uint16: 0x0103

Profile Descriptor List:

"AV Remote" (0x110e)

Version: 0x0105


Service Name: Message Notification

Service RecHandle: 0x10005

Service Class ID List:

"Message Access - MNS" (0x1133)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 17

"OBEX" (0x0008)

Profile Descriptor List:

"Message Access" (0x1134)

Version: 0x0102


Browsing FF:FF:FF:00:00:00 =E2=80=A6

Service Search failed: Invalid argument

Service Name: Message Access

Service RecHandle: 0x10006

Service Class ID List:

"Message Access - MAS" (0x1132)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 16

"OBEX" (0x0008)

Profile Descriptor List:

"Message Access" (0x1134)

Version: 0x0100


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: Invalid argument

Service Name: Phone Book Access

Service RecHandle: 0x10007

Service Class ID List:

"Phonebook Access - PSE" (0x112f)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 15

"OBEX" (0x0008)

Profile Descriptor List:

"Phonebook Access" (0x1130)

Version: 0x0101


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: Invalid argument

Service Name: Synchronization

Service RecHandle: 0x10008

Service Class ID List:

"IrMC Sync" (0x1104)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 14

"OBEX" (0x0008)

Profile Descriptor List:

"IrMC Sync" (0x1104)

Version: 0x0100


Service Name: File Transfer

Service RecHandle: 0x10009

Service Class ID List:

"OBEX File Transfer" (0x1106)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 10

"OBEX" (0x0008)

Profile Descriptor List:

"OBEX File Transfer" (0x1106)

Version: 0x0102


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: Invalid argument

Service Name: Object Push

Service RecHandle: 0x1000a

Service Class ID List:

"OBEX Object Push" (0x1105)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 9

"OBEX" (0x0008)

Profile Descriptor List:

"OBEX Object Push" (0x1105)

Version: 0x0102


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: No data available

Service Name: Nokia OBEX PC Suite Services

Service RecHandle: 0x1000b

Service Class ID List:

UUID 128: 00005005-0000-1000-8000-0002ee000001

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 24

"OBEX" (0x0008)

Profile Descriptor List:

"" (0x00005005-0000-1000-8000-0002ee000001)

Version: 0x0100


Service Name: Audio Source

Service RecHandle: 0x1000c

Service Class ID List:

"Audio Source" (0x110a)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 25

"AVDTP" (0x0019)

uint16: 0x0103

Profile Descriptor List:

"Advanced Audio" (0x110d)

Version: 0x0103


Service Name: Audio Sink

Service RecHandle: 0x1000d

Service Class ID List:

"Audio Sink" (0x110b)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 25

"AVDTP" (0x0019)

uint16: 0x0103

Profile Descriptor List:

"Advanced Audio" (0x110d)

Version: 0x0103


Service Name: Headset Voice gateway

Service RecHandle: 0x1000e

Service Class ID List:

"Headset Audio Gateway" (0x1112)

"Generic Audio" (0x1203)

Protocol Descriptor List:

"L2CAP" (0x0100)

"RFCOMM" (0x0003)

Channel: 12

Profile Descriptor List:

"Headset" (0x1108)

Version: 0x0102



In the opening comments of the code, there are comments about modifying the
main.conf file for BT.  What I have found is that modifying this file seems
to make no difference in the actual settings.  In order to make those
changes to the configuration, I wrote a simple bash script that I run
before attempting to run the program.  Am I correct in reading somewhere
that the main.conf file has been depreciated in the current version of
Bluez?

Here is my script

#!/bin/bash
#
# Must be run as sudo
#

echo "Set Class"
# Set class to be that of a 'keyboard' type
hciconfig hci0 class 0x000540
echo " Class Done"
echo " "

echo "Set Name"
# Set the name of the BT device that other BT
# devices will report / see
hciconfig hci0 name 'AO_L_Turn'
echo " Name Done"
echo " "

echo "Set SSP Mode"
# Set the SSP Mode
hciconfig hci0 sspmode 1
echo "  Mode Done"
echo " "

# Disable simple pairing mode (per original author)
sdptool del 0x10000
sdptool del 0x10001
sdptool del 0x10002
sdptool del 0x10003
sdptool del 0x10004
sdptool del 0x10005
sdptool del 0x10006
sdptool del 0x10007
sdptool del 0x10008
sdptool del 0x10009
sdptool del 0x1000A
sdptool del 0x1000B
sdptool del 0x1000C
sdptool del 0x1000D
sdptool del 0x1000E
sdptool del 0x1000F


This appears to accomplish what the original author desired.  Running
sdptool browse local reveals no entries.

Firstly I run the program with the -l flag to find out what device number
my external keyboard is.  Typically it is "5".

Then I execute the program with the following:

sudo HID_Test2 -e5 -x

Everything fires up and the output looks like this:

temp@temp-ThinkPad-SL510:~/workspace/HID_Test2/Release$ sudo HID_Test2 -e5
-x

HID keyboard/mouse service registered

Opened /dev/input/event5 as event device [counter 0]

The HID-Client is now ready to accept connections from another machine


And that's where it sits.

While the program is running I can check sdptool and it shows the following=
:

temp@temp-ThinkPad-SL510:~$ sudo sdptool browse local

[sudo] password for temp:

Browsing FF:FF:FF:00:00:00 ...

Service Name: Bluez virtual Mouse and Keyboard

Service Description: Keyboard

Service Provider: Anselm Martin Hoffmeister (GPL v2)

Service RecHandle: 0x10000

Service Class ID List:

"Human Interface Device" (0x1124)

Protocol Descriptor List:

"L2CAP" (0x0100)

PSM: 17

"HIDP" (0x0011)

Language Base Attr List:

code_ISO639: 0x656e

encoding: 0x6a

base_offset: 0x100

Profile Descriptor List:

"" (0x0011)

Version: 0x0100


Browsing FF:FF:FF:00:00:00 ...

Service Search failed: Success


I attempt to connect my phone and here is the hcidump output.  It appears
to connect, then disconnects right away..

temp@temp-ThinkPad-SL510:~$ hcidump hci0

HCI sniffer - Bluetooth packet analyzer ver 5.37

device: hci0 snap_len: 1500 filter: 0xffffffffffffffff

> HCI Event: Connect Request (0x04) plen 10

bdaddr 10:D5:42:BB:1F:F5 class 0x5a020c type ACL

> HCI Event: Command Status (0x0f) plen 4

Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

status 0x00 handle 12 bdaddr 10:D5:42:BB:1F:F5 type ACL encrypt 0x00

> HCI Event: Command Status (0x0f) plen 4

Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

> HCI Event: Read Remote Supported Features (0x0b) plen 11

status 0x00 handle 12

Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87

> HCI Event: Command Status (0x0f) plen 4

Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1

> HCI Event: Read Remote Extended Features (0x23) plen 13

status 0x00 handle 12 page 1 max 1

Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00

> HCI Event: Command Status (0x0f) plen 4

Remote Name Request (0x01|0x0019) status 0x00 ncmd 1

> HCI Event: Remote Name Req Complete (0x07) plen 255

status 0x00 bdaddr 10:D5:42:BB:1F:F5 name 'SPH-L720'

> HCI Event: Command Complete (0x0e) plen 10

IO Capability Request Reply (0x01|0x002b) ncmd 1

status 0x00 bdaddr 10:D5:42:BB:1F:F5

> HCI Event: Command Complete (0x0e) plen 10

User Confirmation Request Reply (0x01|0x002c) ncmd 1

status 0x00 bdaddr 10:D5:42:BB:1F:F5

> HCI Event: Encrypt Change (0x08) plen 4

status 0x00 handle 12 encrypt 0x01

> HCI Event: Command Complete (0x0e) plen 7

Read Encryption Key Size (0x05|0x0008) ncmd 1

> HCI Event: Command Status (0x0f) plen 4

Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

status 0x00 handle 12 reason 0x16

Reason: Connection Terminated by Local Host

> HCI Event: Connect Request (0x04) plen 10

bdaddr 10:D5:42:BB:1F:F5 class 0x5a020c type ACL

> HCI Event: Command Status (0x0f) plen 4

Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

status 0x00 handle 11 bdaddr 10:D5:42:BB:1F:F5 type ACL encrypt 0x00

> HCI Event: Command Status (0x0f) plen 4

Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

> HCI Event: Read Remote Supported Features (0x0b) plen 11

status 0x00 handle 11

Features: 0xbf 0xfe 0xcf 0xff 0xdf 0xff 0x7b 0x87

> HCI Event: Command Status (0x0f) plen 4

Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1

> HCI Event: Read Remote Extended Features (0x23) plen 13

status 0x00 handle 11 page 1 max 1

Features: 0x07 0x00 0x00 0x00 0x00 0x00 0x00 0x00

> HCI Event: Command Status (0x0f) plen 4

Remote Name Request (0x01|0x0019) status 0x00 ncmd 1

> HCI Event: Remote Name Req Complete (0x07) plen 255

status 0x00 bdaddr 10:D5:42:BB:1F:F5 name 'SPH-L720'

> HCI Event: Command Complete (0x0e) plen 10

Link Key Request Reply (0x01|0x000b) ncmd 1

status 0x00 bdaddr 10:D5:42:BB:1F:F5

> HCI Event: Encrypt Change (0x08) plen 4

status 0x00 handle 11 encrypt 0x01

> HCI Event: Command Complete (0x0e) plen 7

Read Encryption Key Size (0x05|0x0008) ncmd 1

> HCI Event: Command Status (0x0f) plen 4

Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

status 0x00 handle 11 reason 0x16

Reason: Connection Terminated by Local Host

^C



I'll be honest and say that I'm not sure I understand all the output from
the hcidump.

Can someone out there tell me where I've gone off into the weeds?

I'm guessing that there is something about this code that is not completely
compatible with the current version of Bluez?  The author apparently had to
make some adjustments back in 2012 to make the application work with the
current version of the BT stack.

I hope I've provided enough information for starters.  Again, I'm new to
the world of BT and somewhat new to the Linux environment but I'm trying.

Thank you in advance for your time,




/*
 * HID2.c
 *
 *  Created on: Dec 27, 2016
 *      Author: temp
 */
/*
 * hidclient - A Bluetooth HID client device emulation
 *
 *        A bluetooth/bluez software emulating a bluetooth mouse/keyboard
 *        combination device - use it to transmit mouse movements and
 *        keyboard keystrokes from a Linux box to any other BTHID enabled
 *        computer or compatible machine
 *
 *
 * Implementation
 * 2004-2006    by Anselm Martin Hoffmeister
 *            <stockholm(at)users(period)sourceforge(period)net>
 * 2004/2005    Implementation for the GPLed Nokia-supported Affix Bluetoot=
h
 *         stack as a practical work at
 *         Rheinische Friedrich-Wilhelms-Universit=C3=83=E2=82=ACt, Bonn, G=
ermany
 * 2006        Software ported to Bluez, several code cleanups
 * 2006-07-25    First public release
 *
 * Updates
 * 2012-02-10    by Peter G
 *        Updated to work with current distro (Lubuntu 11.10)
 *        EDIT FILE /etc/bluetooth/main.conf
 *        to include:
 *            DisablePlugins =3D network,input,hal,pnat
 *        AMH: Just disable input might be good enough.
 *        recomended to change:
 *            Class =3D 0x000540
 *        AMH: This leads to the device being found as "Keyboard".
 *        Some devices might ignore non-0x540 input devices
 *        before starting, also execute the following commands
 *            hciconfig hci0 class 0x000540
 *            # AMH: Should be optional if Class=3D set (above)
 *            hciconfig hci0 name \'Bluetooth Keyboard\'
 *            # AMH: Optional: Name will be seen by other BTs
 *            hciconfig hci0 sspmode 0
 *            # AMH: Optional: Disables simple pairing mode
 *            sdptool del 0x10000
 *            sdptool del 0x10001
 *            sdptool del 0x10002
 *            sdptool del 0x10003
 *            sdptool del 0x10004
 *            sdptool del 0x10005
 *            sdptool del 0x10006
 *            sdptool del 0x10007
 *            sdptool del 0x10008
 *            # This removes any non-HID SDP entries.
 *            # Might help if other devices only like
 *            # single-function Bluetooth devices
 *            # Not strictly required though.
 * 2012-07-26    Several small updates necessary to work on
 *        Ubuntu 12.04 LTS on amd64
 *        Added -e, -l, -x
 * 2012-07-28    Add support for FIFO operation (-f/filename)
 *
 * Dependency:    Needs libbluetooth (from bluez)
 *
 * Usage:    hidclient [-h|-?|--help] [-s|--skipsdp]
 *         Start hidclient. -h will display usage information.
 *        -e<NUM> asks hidclient to ONLY use Input device #NUM
 *        -f<FILENAME> will not read event devices, but create a
 *           fifo on <FILENAME> and read input_event data blocks
 *           from there
 *        -l will list input devices available
 *        -x will try to remove the "grabbed" input devices from
 *           the local X11 server, if possible
 *         -s will disable SDP registration (which only makes sense
 *         when debugging as most counterparts require SDP to work)
 * Tip:        Use "openvt" along with hidclient so that keystrokes and
 *         mouse events captured will have no negative impact on the
 *         local machine (except Ctrl+Alt+[Fn/Entf/Pause]).
 *         Run
 *         openvt -s -w hidclient
 *         to run hidclient on a virtual text mode console for itself.
 * Alternative:    Use "hidclient" in a X11 session after giving the active
 *        user read permissions on the /dev/input/event<NUM> devices
 *        you intend to use. With the help of -x (and possibly -e<NUM>)
 *        this should simply disattach input devices from the local
 *        machine while hidclient is running (and hopefully, reattach
 *        them afterwards, of course).
 *
 * License:
 *        This program is free software; you can redistribute it and/or
 *        modify it under the terms of the GNU General Public License as
 *        published by the Free Software Foundation;
 *        strictly version 2 only.
 *
 *        This program is distributed in the hope that it will be useful,
 *        but WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *        GNU General Public License for more details.
 *
 *        You should have received a copy of the GNU General Public
 *        License    along with this program; if not, write to the
 *        Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 *        Boston, MA  02110-1301  USA
 */
//***************** Include files
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stropts.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <linux/input.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>
//{#include <bluetooth/sdp.h>}
//{#include <bluetooth/sdp_lib.h>}
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

//***************** Static definitions
// Where to find event devices (that must be readable by current user)
// "%d" to be filled in, opening several devices, see below
#define    EVDEVNAME    "/dev/input/event%d"

// Maximally, read MAXEVDEVS event devices simultaneously
#define    MAXEVDEVS 16

// Bluetooth "ports" (PSMs) for HID usage, standardized to be 17 and 19
resp.
// In theory you could use different ports, but several implementations see=
m
// to ignore the port info in the SDP records and always use 17 and 19.
YMMV.
#define    PSMHIDCTL    0x11
#define    PSMHIDINT    0x13

// Information to be submitted to the SDP server, as service description
#define    HIDINFO_NAME    "Bluez virtual Mouse and Keyboard"
#define    HIDINFO_PROV    "Anselm Martin Hoffmeister (GPL v2)"
#define    HIDINFO_DESC    "Keyboard"

// These numbers must also be used in the HID descriptor binary file
#define    REPORTID_MOUSE    1
#define    REPORTID_KEYBD    2

// Fixed SDP record, corresponding to data structures below. Explanation
// is in separate text file. No reason to change this if you do not want
// to fiddle with the data sent over the BT connection as well.
#define SDPRECORD    "\x05\x01\x09\x02\xA1\x01\x85\x01\x09\x01\xA1\x00" \
            "\x05\x09\x19\x01\x29\x03\x15\x00\x25\x01\x75\x01" \
            "\x95\x03\x81\x02\x75\x05\x95\x01\x81\x01\x05\x01" \
            "\x09\x30\x09\x31\x09\x38\x15\x81\x25\x7F\x75\x08" \
            "\x95\x02\x81\x06\xC0\xC0\x05\x01\x09\x06\xA1\x01" \
            "\x85\x02\xA1\x00\x05\x07\x19\xE0\x29\xE7\x15\x00" \
            "\x25\x01\x75\x01\x95\x08\x81\x02\x95\x08\x75\x08" \
            "\x15\x00\x25\x65\x05\x07\x19\x00\x29\x65\x81\x00" \
            "\xC0\xC0"
#define SDPRECORD_BYTES    98

//***************** Function prototypes
int        dosdpregistration(void);
void        sdpunregister(unsigned int);
static void    add_lang_attr(sdp_record_t *r);
int        btbind(int sockfd, unsigned short port);
int        initevents(int,int);
void        closeevents(void);
int        initfifo(char *);
void        closefifo(void);
void        cleanup_stdin(void);
int        add_filedescriptors(fd_set*);
int        parse_events(fd_set*,int);
void        showhelp(void);
void        onsignal(int);

//***************** Data structures
// Mouse HID report, as sent over the wire:
struct hidrep_mouse_t
{
    unsigned char    btcode;    // Fixed value for "Data Frame": 0xA1
    unsigned char    rep_id; // Will be set to REPORTID_MOUSE for "mouse"
    unsigned char    button;    // bits 0..2 for left,right,middle, others =
0
    signed   char    axis_x; // relative movement in pixels, left/right
    signed   char    axis_y; // dito, up/down
    signed   char    axis_z; // Used for the scroll wheel (?)
} __attribute((packed));
// Keyboard HID report, as sent over the wire:
struct hidrep_keyb_t
{
    unsigned char    btcode; // Fixed value for "Data Frame": 0xA1
    unsigned char    rep_id; // Will be set to REPORTID_KEYBD for "keyboard=
"
    unsigned char    modify; // Modifier keys (shift, alt, the like)
    unsigned char    key[8]; // Currently pressed keys, max 8 at once
} __attribute((packed));

//***************** Global variables
char        prepareshutdown     =3D 0;    // Set if shutdown was requested
int        eventdevs[MAXEVDEVS];    // file descriptors
int        x11handles[MAXEVDEVS];
char        mousebuttons     =3D 0;    // storage for button status
char        modifierkeys     =3D 0;    // and for shift/ctrl/alt... status
char        pressedkey[8]     =3D { 0, 0, 0, 0,  0, 0, 0, 0 };
char        connectionok     =3D 0;
uint32_t    sdphandle     =3D 0;    // To be used to "unregister" on exit
int        debugevents      =3D 0;    // bitmask for debugging event data

//***************** Implementation
/*
 * Taken from bluetooth library because of suspicious memory allocation
 * THIS IS A HACK that appears to work, and did not need to look into how
it works
 * SHOULD BE FIXED AND FIX BACKPORTED TO BLUEZ
 */
sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int
*length,
                                int len)
{
    sdp_data_t *curr =3D NULL, *seq =3D NULL;
    int i;
    int totall =3D 1024;

    for (i =3D 0; i < len; i++) {
        sdp_data_t *data;
        int8_t dtd =3D *(uint8_t *) dtds[i];


        if (dtd >=3D SDP_SEQ8 && dtd <=3D SDP_ALT32) {
            data =3D (sdp_data_t *) values[i];
            }
        else {
            data =3D sdp_data_alloc_with_length(dtd, values[i], length[i]);
            }

        if (!data)
            return NULL;

        if (curr)
            curr->next =3D data;
        else
            seq =3D data;

        curr =3D data;
        totall +=3D  length[i] + sizeof *seq; /* no idea what this should
really be */
    }
/*
 * Here we had a reference here to a non-existing array member. Changed it
something that
 * appears to be large enough BUT author has no idea what it really should
be
 */
//  fprintf ( stderr, "length[%d]): %d, totall: %d\n", i, length[i],
totall);

    return sdp_data_alloc_with_length(SDP_SEQ8, seq, totall);
}

/*
 * dosdpregistration -    Care for the proper SDP record sent to the "sdpd"
 *            so that other BT devices can discover the HID service
 * Parameters: none; Return value: 0 =3D OK, >0 =3D failure
 */
int    dosdpregistration ( void )
{
    fprintf (stderr, "Start SDP Reg\n");
    sdp_record_t    record;
    sdp_session_t    *session;
    sdp_list_t    *svclass_id,
            *pfseq,
            *apseq,
            *root;
    uuid_t        root_uuid,
            hidkb_uuid,
            l2cap_uuid,
            hidp_uuid;
    sdp_profile_desc_t    profile[1];
    sdp_list_t    *aproto,
            *proto[3];
    sdp_data_t    *psm,
            *lang_lst,
            *lang_lst2,
            *hid_spec_lst,
            *hid_spec_lst2;
    void        *dtds[2],
            *values[2],
            *dtds2[2],
            *values2[2];
    int        i,
            leng[2];
    uint8_t        dtd=3DSDP_UINT16,
            dtd2=3DSDP_UINT8,
            dtd_data=3DSDP_TEXT_STR8,
            hid_spec_type=3D0x22;
    uint16_t    hid_attr_lang[]=3D{0x409, 0x100},
            ctrl=3DPSMHIDCTL,
            intr=3DPSMHIDINT,
            hid_attr[]=3D{0x100, 0x111, 0x40, 0x00, 0x01, 0x01},
            // Assigned to SDP 0x200...0x205 - see HID SPEC for
            // details. Those values seem to work fine...
            // "it\'s a kind of magic" numbers.
            hid_attr2[]=3D{0x100, 0x0};
fprintf (stderr, "Init SDP Reg Done\n");
// Connect to SDP server on localhost, to publish service information
    session =3D sdp_connect ( BDADDR_ANY, BDADDR_LOCAL, 0 );
    if ( ! session )
    {
        fprintf ( stderr, "Failed to connect to SDP server: %s\n",
                strerror ( errno ) );
        return    1;
    }
        memset(&record, 0, sizeof(sdp_record_t));
        record.handle =3D 0xffffffff;
    // With 0xffffffff, we get assigned the first free record >=3D 0x10000
    // Make HID service visible (add to PUBLIC BROWSE GROUP)
        sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
        root =3D sdp_list_append(0, &root_uuid);
        sdp_set_browse_groups(&record, root);
    // Language Information to be added
        add_lang_attr(&record);
    // The descriptor for the keyboard
        sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
        svclass_id =3D sdp_list_append(0, &hidkb_uuid);
        sdp_set_service_classes(&record, svclass_id);
    // And information about the HID profile used
        sdp_uuid16_create(&profile[0].uuid, HIDP_UUID /*HID_PROFILE_ID*/);
        profile[0].version =3D 0x0100;
        pfseq =3D sdp_list_append(0, profile);
        sdp_set_profile_descs(&record, pfseq);
    // We are using L2CAP, so add an info about that
        sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
        proto[1] =3D sdp_list_append(0, &l2cap_uuid);
        psm =3D sdp_data_alloc(SDP_UINT16, &ctrl);
        proto[1] =3D sdp_list_append(proto[1], psm);
        apseq =3D sdp_list_append(0, proto[1]);
    // And about our purpose, the HID protocol data transfer
        sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
        proto[2] =3D sdp_list_append(0, &hidp_uuid);
        apseq =3D sdp_list_append(apseq, proto[2]);
        aproto =3D sdp_list_append(0, apseq);
        sdp_set_access_protos(&record, aproto);
        proto[1] =3D sdp_list_append(0, &l2cap_uuid);
        psm =3D sdp_data_alloc(SDP_UINT16, &intr);
        proto[1] =3D sdp_list_append(proto[1], psm);
        apseq =3D sdp_list_append(0, proto[1]);
        sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
        proto[2] =3D sdp_list_append(0, &hidp_uuid);
        apseq =3D sdp_list_append(apseq, proto[2]);
        aproto =3D sdp_list_append(0, apseq);
        sdp_set_add_access_protos(&record, aproto);
    // Set service name, description
        sdp_set_info_attr(&record, HIDINFO_NAME, HIDINFO_PROV,
HIDINFO_DESC);
    // Add a few HID-specifid pieces of information
        // See the HID spec for details what those codes 0x200+something
    // are good for... we send a fixed set of info that seems to work
        sdp_attr_add_new(&record, SDP_ATTR_HID_DEVICE_RELEASE_NUMBER,
                                        SDP_UINT16, &hid_attr[0]); /* Opt *=
/
        sdp_attr_add_new(&record, SDP_ATTR_HID_PARSER_VERSION,
                                        SDP_UINT16, &hid_attr[1]); /* Mand
*/
        sdp_attr_add_new(&record, SDP_ATTR_HID_DEVICE_SUBCLASS,
                                        SDP_UINT8, &hid_attr[2]); /* Mand *=
/
        sdp_attr_add_new(&record, SDP_ATTR_HID_COUNTRY_CODE,
                                        SDP_UINT8, &hid_attr[3]); /* Mand *=
/
        sdp_attr_add_new(&record, SDP_ATTR_HID_VIRTUAL_CABLE,
                                  SDP_BOOL, &hid_attr[4]); /* Mand */
        sdp_attr_add_new(&record, SDP_ATTR_HID_RECONNECT_INITIATE,
                                  SDP_BOOL, &hid_attr[5]); /* Mand */
    // Add the HID descriptor (describing the virtual device) as code
    // SDP_ATTR_HID_DESCRIPTOR_LIST (0x206 IIRC)
        dtds[0] =3D &dtd2;
        values[0] =3D &hid_spec_type;
        dtd_data=3D SDPRECORD_BYTES <=3D 255 ? SDP_TEXT_STR8 : SDP_TEXT_STR=
16 ;
        dtds[1] =3D &dtd_data;
        values[1] =3D (uint8_t *) SDPRECORD;
        leng[0] =3D 0;
        leng[1] =3D SDPRECORD_BYTES;
        hid_spec_lst =3D sdp_seq_alloc_with_length(dtds, values, leng, 2);
        hid_spec_lst2 =3D sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
        sdp_attr_add(&record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
    // and continue adding further data bytes for 0x206+x values
        for (i =3D 0; i < sizeof(hid_attr_lang) / 2; i++) {
                dtds2[i] =3D &dtd;
                values2[i] =3D &hid_attr_lang[i];
            }
        lang_lst =3D sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang) / =
2);
        lang_lst2 =3D sdp_data_alloc(SDP_SEQ8, lang_lst);
        sdp_attr_add(&record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
        sdp_attr_add_new ( &record, SDP_ATTR_HID_PROFILE_VERSION,
            SDP_UINT16, &hid_attr2[0] );
        sdp_attr_add_new ( &record, SDP_ATTR_HID_BOOT_DEVICE,
            SDP_UINT16, &hid_attr2[1] );
    // Submit our IDEA of a SDP record to the "sdpd"
        if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) =
{
                fprintf ( stderr, "Service Record registration failed\n" );
                return -1;
        }
    // Store the service handle retrieved from there for reference (i.e.,
    // deleting the service info when this program terminates)
        sdphandle =3D record.handle;
        fprintf ( stdout, "HID keyboard/mouse service registered\n" );
        return 0;
}

/*
 *     sdpunregister - Remove SDP entry for HID service on program
termination
 *     Parameters: SDP handle (typically 0x10004 or similar)
 */
void    sdpunregister ( uint32_t handle )
{
        uint32_t    range=3D0x0000ffff;
    sdp_list_t    *    attr;
    sdp_session_t *    sess;
    sdp_record_t  *    rec;
    // Connect to the local SDP server
    sess =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
    if ( !sess )    return;
    attr =3D sdp_list_append(0, &range);
    rec =3D sdp_service_attr_req(sess, handle, SDP_ATTR_REQ_RANGE, attr);
    sdp_list_free(attr, 0);
    if ( !rec ) {
        sdp_close(sess);
        return;
    }
    sdp_device_record_unregister(sess, BDADDR_ANY, rec);
    sdp_close(sess);
    // We do not care wether unregister fails. If it does, we cannot help
it.
    return;
}

static void add_lang_attr(sdp_record_t *r)
{
        sdp_lang_attr_t base_lang;
        sdp_list_t *langs =3D 0;
        /* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) *=
/
        base_lang.code_ISO639 =3D (0x65 << 8) | 0x6e;
        base_lang.encoding =3D 106;
        base_lang.base_offset =3D SDP_PRIMARY_LANG_BASE;
        langs =3D sdp_list_append(0, &base_lang);
        sdp_set_lang_attr(r, langs);
        sdp_list_free(langs, 0);
}

// Wrapper for bind, caring for all the surrounding variables
int    btbind ( int sockfd, unsigned short port ) {
    struct sockaddr_l2 l2a;
    int i;
    memset ( &l2a, 0, sizeof(l2a) );
    l2a.l2_family =3D AF_BLUETOOTH;
    bacpy ( &l2a.l2_bdaddr, BDADDR_ANY );
    l2a.l2_psm =3D htobs ( port );
    i =3D bind ( sockfd, (struct sockaddr *)&l2a, sizeof(l2a) );
    if ( 0 > i )
    {
        fprintf ( stderr, "Bind error (PSM %d): %s\n",
                port, strerror ( errno ) );
    }
    return    i;
}


/*
 *    initfifo(filename) - creates (if necessary) and opens fifo
 *    instead of event devices. If filename exists and is NOT a fifo,
 *    abort with error.
 */
int    initfifo ( char *filename )
{
    struct stat ss;
    if ( NULL =3D=3D filename ) return 0;
    if ( 0 =3D=3D stat ( filename, &ss ) )
    {
        if ( ! S_ISFIFO(ss.st_mode) )
        {
            fprintf(stderr,"File [%s] exists, but is not a fifo.\n",
filename );
            return 0;
        }
    } else {
        if ( 0 !=3D mkfifo ( filename, S_IRUSR | S_IWUSR ) )
        {    // default permissions for created fifo is rw------- (user=3Dr=
w)
            fprintf(stderr,"Failed to create new fifo [%s]\n", filename );
            return 0;
        }
    }
    eventdevs[0] =3D open ( filename, O_RDONLY | O_NONBLOCK );
    if ( 0 > eventdevs[0] )
    {
        fprintf ( stderr, "Failed to open fifo [%s] for reading.\n",
filename );
        return 0;
    }
    return    1;
}

/*
 *     initevents () - opens all required event files
 *     or only one device, if number useonlyone is >=3D 0
 *    try to disable in X11 if mutex11 is set to 1
 *     returns number of successfully opened event file nodes, or <1 for
error
 */
int    initevents ( int useonlyone, int mutex11 )
{
    int    i, j, k;
    char    buf[sizeof(EVDEVNAME)+8];
    char    *xinlist =3D NULL;
    FILE    *pf;
    char    *p, *q;
    if ( mutex11 )
    {
        if ( NULL =3D=3D ( xinlist =3D malloc ( 4096 ) ) )
        {
            printf ( "Memory alloc error\n" );
            return 0;
        }
        bzero ( xinlist, 4096 );
        if ( NULL !=3D ( pf =3D popen ("xinput --list --short", "r" ) ) )
        {
            if ( 1 > fread ( xinlist, 1, 3800, pf ) )
            {
                printf ( "\tx11-mutable information not available.\n" );
                free ( xinlist );
                xinlist =3D NULL;
            }
        }
        fclose ( pf );
    }
    for ( i =3D 0; i < MAXEVDEVS; ++i )
    {
        eventdevs[i] =3D -1;
        x11handles[i] =3D -1;
    }
    for ( i =3D j =3D 0; j < MAXEVDEVS; ++j )
    {
        if ( ( useonlyone >=3D 0 ) && ( useonlyone !=3D j ) ) { continue; }
        sprintf ( buf, EVDEVNAME, j );
        eventdevs[i] =3D open ( buf, O_RDONLY );
        if ( 0 <=3D eventdevs[i] )
        {
            fprintf ( stdout, "Opened %s as event device [counter %d]\n",
buf, i );
            if ( ( mutex11 > 0 ) && ( xinlist !=3D NULL ) )
            {
                k =3D -1;
                xinlist[3801] =3D 0;
                if ( ioctl(eventdevs[i], EVIOCGNAME(256),xinlist+3801) >=3D=
 0
)
                {
                    p =3D xinlist;
                    xinlist[4056] =3D 0;
                    if ( strlen(xinlist+3801) < 4 ) // min lenght for name
                        p =3D xinlist + 4056;
                    while ( (*p !=3D 0) &&
                        ( NULL !=3D ( p =3D strstr ( p, xinlist+3801 ) ) ) =
)
                    {
                        q =3D p + strlen(xinlist+3801);
                        while ( *q =3D=3D ' ' ) ++q;
                        if ( strncmp ( q, "\tid=3D", 4 ) =3D=3D 0 )
                        {
                            k =3D atoi ( q + 4 );
                            p =3D xinlist + 4056;
                        } else {
                            p =3D q;
                        }
                    }
                }
                if ( k >=3D 0 ) {
                    sprintf ( xinlist+3801, "xinput set-int-prop %d
\"Device "\
                        "Enabled\" 8 0", k );
                    if ( system ( xinlist + 3801 ) )
                    {
                        fprintf ( stderr, "Failed to x11-mute.\n" );
                    }
                    x11handles[i] =3D k;
                }
            }
            ++i;
        }
    }
    if ( xinlist !=3D NULL ) { free ( xinlist ); }
    return    i;
}

void    closeevents ( void )
{
    int    i;
    char    buf[256];
    for ( i =3D 0; i < MAXEVDEVS; ++i )
    {
        if ( eventdevs[i] >=3D 0 )
        {
            close ( eventdevs[i] );
            if ( x11handles[i] >=3D 0 )
            {
                sprintf ( buf, "xinput set-int-prop %d \"Device "\
                "Enabled\" 8 1", x11handles[i] );
                if ( system ( buf ) )
                {
                    fprintf ( stderr, "Failed to x11-unmute device %d.\n",
i );
                }
            }
        }
    }
    return;
}

void    closefifo ( void )
{
    if ( eventdevs[0] >=3D 0 )
        close(eventdevs[0]);
    return;
}

void    cleanup_stdin ( void )
{
    // Cleans everything but the characters after the last ENTER keypress.
    // This is necessary BECAUSE while reading all keyboard input from the
    // event devices, those key presses will still stay in the stdin queue.
    // We do not want to have a backlog of hundreds of characters, possibly
    // commands and so on.
    fd_set fds;
    struct timeval tv;
    FD_ZERO ( &fds );
    FD_SET ( 0, &fds );
    tv.tv_sec  =3D 0;
    tv.tv_usec =3D 0;
    char buf[8];
    while ( 0 < select ( 1, &fds, NULL, NULL, &tv ) )
    {
        while ( read ( 0, buf, 8 ) ) {;}
        FD_ZERO ( &fds );
        FD_SET ( 0, &fds );
        tv.tv_sec  =3D 0;
        tv.tv_usec =3D 1;
    }
    close ( 0 );
    return;
}

int    add_filedescriptors ( fd_set * fdsp )
{
    // Simply add all open eventdev fds to the fd_set for select.
    int    i, j;
    FD_ZERO ( fdsp );
    j =3D -1;
    for ( i =3D 0; i < MAXEVDEVS; ++i )
    {
        if ( eventdevs[i] >=3D 0 )
        {
            FD_SET ( eventdevs[i], fdsp );
            if ( eventdevs[i] > j )
            {
                j =3D eventdevs[i];
            }
        }
    }
    return    j;
}

/*
 *    list_input_devices - Show a human-readable list of all input devices
 *    the current user has permissions to read from.
 *    Add info wether this probably can be "muted" in X11 if requested
 */
int    list_input_devices ()
{
    int    i, fd;
    char    buf[sizeof(EVDEVNAME)+8];
    struct input_id device_info;
    char    namebuf[256];
    char    *xinlist;
    FILE    *pf;
    char    *p, *q;
    char    x11 =3D 0;
    if ( NULL =3D=3D ( xinlist =3D malloc ( 4096 ) ) )
    {
        printf ( "Memory alloc error\n" );
        return    1;
    }
    bzero ( xinlist, 4096 );
    if ( NULL !=3D ( pf =3D popen ("xinput --list --name-only", "r" ) ) )
    {
        if ( 1 > fread ( xinlist, 1, 4095, pf ) )
        {
            printf ( "\tx11-mutable information not available.\n" );
        }
        fclose ( pf );
    }
    printf ( "List of available input devices:\n");
    printf ( "num\tVendor/Product, Name, -x compatible (x/-)\n" );
    for ( i =3D 0; i < MAXEVDEVS; ++i )
    {
        sprintf ( buf, EVDEVNAME, i );
        fd =3D open ( buf, O_RDONLY );
        if ( fd < 0 )
        {
            if ( errno =3D=3D ENOENT ) { i =3D MAXEVDEVS ; break; }
            if ( errno =3D=3D EACCES )
            {
                printf ( "%2d:\t[permission denied]\n", i );
            }
            continue;
        }
        if ( ioctl ( fd, EVIOCGID, &device_info ) < 0 )
        {
            close(fd); continue;
        }
        if ( ioctl ( fd, EVIOCGNAME(sizeof(namebuf)-4), namebuf+2) < 0 )
        {
            close(fd); continue;
        }
        namebuf[sizeof(namebuf)-4] =3D 0;
        x11 =3D 0;
        p =3D xinlist;
        while ( ( p !=3D NULL ) && ( *p !=3D 0 ) )
        {
            if ( NULL =3D=3D ( q =3D strchr ( p, 0x0a ) ) ) { break; }
            *q =3D 0;
            if ( strcmp ( p, namebuf + 2 ) =3D=3D 0 ) { x11 =3D 1; }
            *q =3D 0x0a;
            while ( (*q > 0) && (*q <=3D 0x20 ) ) { ++q; }
            p =3D q;
        }
        printf("%2d\t[%04hx:%04hx.%04hx] '%s' (%s)", i,
            device_info.vendor, device_info.product,
            device_info.version, namebuf + 2, x11 ? "+" : "-");
        printf("\n");
        close ( fd );
    }
    free ( xinlist );
    return    0;
}

/*    parse_events - At least one filedescriptor can now be read
 *    So retrieve data and parse it, eventually sending out a hid report!
 *    Return value <0 means connection broke and shall be disconnected
 */
int    parse_events ( fd_set * efds, int sockdesc )
{
    int    i, j;
    signed char    c;
    unsigned char    u;
    char    buf[sizeof(struct input_event)];
    char    hidrep[32]; // mouse ~6, keyboard ~11 chars
    struct input_event    * inevent =3D (void *)buf;
    struct hidrep_mouse_t * evmouse =3D (void *)hidrep;
    struct hidrep_keyb_t  * evkeyb  =3D (void *)hidrep;
    if ( efds =3D=3D NULL ) { return -1; }
    for ( i =3D 0; i < MAXEVDEVS; ++i )
    {
        if ( 0 > eventdevs[i] ) continue;
        if ( ! ( FD_ISSET ( eventdevs[i], efds ) ) ) continue;
        j =3D read ( eventdevs[i], buf, sizeof(struct input_event) );
        if ( j =3D=3D 0 )
        {
            if ( debugevents & 0x1 ) fprintf(stderr,".");
            continue;
        }
        if ( -1 =3D=3D j )
        {
            if ( debugevents & 0x1 )
            {
                if ( errno > 0 )
                {
                    fprintf(stderr,"%d|%d(%s) (expected %d bytes).
",eventdevs[i],errno,strerror(errno), (int)sizeof(struct input_event));
                }
                else
                {
                    fprintf(stderr,"j=3D-1,errno<=3D0...");
                }
            }
            continue;
        }
        if ( sizeof(struct input_event) > j )
        {
            // exactly 24 on 64bit, (16 on 32bit): sizeof(struct
input_event)
            //  chars expected !=3D got: data invalid, drop it!
            continue;
        }
        fprintf(stderr,"   read(%d)from(%d)   ", j, i );
        if ( debugevents & 0x1 )
            fprintf ( stdout, "EVENT{%04X %04X %08X}\n", inevent->type,
              inevent->code, inevent->value );
        switch ( inevent->type )
        {
          case    EV_SYN:
            break;
          case    EV_KEY:
            u =3D 1; // Modifier keys
            switch ( inevent->code )
            {
              // *** Mouse button events
              case    BTN_LEFT:
              case    BTN_RIGHT:
              case    BTN_MIDDLE:
                c =3D 1 << (inevent->code & 0x03);
                mousebuttons =3D mousebuttons & (0x07-c);
                if ( inevent->value =3D=3D 1 )
                // Key has been pressed DOWN
                {
                    mousebuttons=3Dmousebuttons | c;
                }
                evmouse->btcode =3D 0xA1;
                evmouse->rep_id =3D REPORTID_MOUSE;
                evmouse->button =3D mousebuttons & 0x07;
                evmouse->axis_x =3D
                evmouse->axis_y =3D
                evmouse->axis_z =3D 0;
                if ( ! connectionok )
                    break;
                j =3D send ( sockdesc, evmouse,
                    sizeof(struct hidrep_mouse_t),
                    MSG_NOSIGNAL );
                if ( 1 > j )
                {
                    return    -1;
                }
                break;
              // *** Special key: PAUSE
              case    KEY_PAUSE:
                // When pressed: abort connection
                if ( inevent->value =3D=3D 0 )
                {
                    if ( connectionok )
                    {
                    evkeyb->btcode=3D0xA1;
                    evkeyb->rep_id=3DREPORTID_KEYBD;
                    memset ( evkeyb->key, 0, 8 );
                    evkeyb->modify =3D 0;
                    j =3D send ( sockdesc, evkeyb,
                      sizeof(struct hidrep_keyb_t),
                      MSG_NOSIGNAL );
                    close ( sockdesc );
                    }
                    // If also LCtrl+Alt pressed:
                    // Terminate program
                    if (( modifierkeys & 0x5 ) =3D=3D 0x5 )
                    {
                    return    -99;
                    }
                    return -1;
                }
                break;
              // *** "Modifier" key events
              case    KEY_RIGHTMETA:
                u <<=3D 1;
                break;
              case    KEY_RIGHTALT:
                u <<=3D 1;
                break;
              case    KEY_RIGHTSHIFT:
                u <<=3D 1;
                break;
              case    KEY_RIGHTCTRL:
                u <<=3D 1;
                break;
              case    KEY_LEFTMETA:
                u <<=3D 1;
                break;
              case    KEY_LEFTALT:
                u <<=3D 1;
                break;
              case    KEY_LEFTSHIFT:
                u <<=3D 1;
                break;
              case    KEY_LEFTCTRL:
                evkeyb->btcode =3D 0xA1;
                evkeyb->rep_id =3D REPORTID_KEYBD;
                memcpy ( evkeyb->key, pressedkey, 8 );
                modifierkeys &=3D ( 0xff - u );
                if ( inevent->value >=3D 1 )
                {
                    modifierkeys |=3D u;
                }
                evkeyb->modify =3D modifierkeys;
                j =3D send ( sockdesc, evkeyb,
                    sizeof(struct hidrep_keyb_t),
                    MSG_NOSIGNAL );
                if ( 1 > j )
                {
                    return    -1;
                }
                break;
              // *** Regular key events
              case    KEY_KPDOT:    ++u;    break; // Keypad Dot ~ 99
              case    KEY_KP0:    ++u;    break; // code 98...
              case    KEY_KP9:    ++u;    break; // countdown...
              case    KEY_KP8:    ++u;    break;
              case    KEY_KP7:    ++u;    break;
              case    KEY_KP6:    ++u;    break;
              case    KEY_KP5:    ++u;    break;
              case    KEY_KP4:    ++u;    break;
              case    KEY_KP3:    ++u;    break;
              case    KEY_KP2:    ++u;    break;
              case    KEY_KP1:    ++u;    break;
              case    KEY_KPENTER:    ++u;    break;
              case    KEY_KPPLUS:    ++u;    break;
              case    KEY_KPMINUS:    ++u;    break;
              case    KEY_KPASTERISK:    ++u;    break;
              case    KEY_KPSLASH:    ++u;    break;
              case    KEY_NUMLOCK:    ++u;    break;
              case    KEY_UP:        ++u;    break;
              case    KEY_DOWN:    ++u;    break;
              case    KEY_LEFT:    ++u;    break;
              case    KEY_RIGHT:    ++u;    break;
              case    KEY_PAGEDOWN:    ++u;    break;
              case    KEY_END:    ++u;    break;
              case    KEY_DELETE:    ++u;    break;
              case    KEY_PAGEUP:    ++u;    break;
              case    KEY_HOME:    ++u;    break;
              case    KEY_INSERT:    ++u;    break;
                        ++u;     break;//[Pause] key
                        // - checked separately
              case    KEY_SCROLLLOCK:    ++u;    break;
              case    KEY_SYSRQ:    ++u;    break; //[printscr]
              case    KEY_F12:    ++u;    break; //F12=3D> code 69
              case    KEY_F11:    ++u;    break;
              case    KEY_F10:    ++u;    break;
              case    KEY_F9:        ++u;    break;
              case    KEY_F8:        ++u;    break;
              case    KEY_F7:        ++u;    break;
              case    KEY_F6:        ++u;    break;
              case    KEY_F5:        ++u;    break;
              case    KEY_F4:        ++u;    break;
              case    KEY_F3:        ++u;    break;
              case    KEY_F2:        ++u;    break;
              case    KEY_F1:        ++u;    break;
              case    KEY_CAPSLOCK:    ++u;    break;
              case    KEY_SLASH:    ++u;    break;
              case    KEY_DOT:    ++u;    break;
              case    KEY_COMMA:    ++u;    break;
              case    KEY_GRAVE:    ++u;    break;
              case    KEY_APOSTROPHE:    ++u;    break;
              case    KEY_SEMICOLON:    ++u;    break;
              case    KEY_102ND:    ++u;    break;
              case    KEY_BACKSLASH:    ++u;    break;
              case    KEY_RIGHTBRACE:    ++u;    break;
              case    KEY_LEFTBRACE:    ++u;    break;
              case    KEY_EQUAL:    ++u;    break;
              case    KEY_MINUS:    ++u;    break;
              case    KEY_SPACE:    ++u;    break;
              case    KEY_TAB:    ++u;    break;
              case    KEY_BACKSPACE:    ++u;    break;
              case    KEY_ESC:    ++u;    break;
              case    KEY_ENTER:    ++u;    break; //Return=3D> code 40
              case    KEY_0:        ++u;    break;
              case    KEY_9:        ++u;    break;
              case    KEY_8:        ++u;    break;
              case    KEY_7:        ++u;    break;
              case    KEY_6:        ++u;    break;
              case    KEY_5:        ++u;    break;
              case    KEY_4:        ++u;    break;
              case    KEY_3:        ++u;    break;
              case    KEY_2:        ++u;    break;
              case    KEY_1:        ++u;    break;
              case    KEY_Z:        ++u;    break;
              case    KEY_Y:        ++u;    break;
              case    KEY_X:        ++u;    break;
              case    KEY_W:        ++u;    break;
              case    KEY_V:        ++u;    break;
              case    KEY_U:        ++u;    break;
              case    KEY_T:        ++u;    break;
              case    KEY_S:        ++u;    break;
              case    KEY_R:        ++u;    break;
              case    KEY_Q:        ++u;    break;
              case    KEY_P:        ++u;    break;
              case    KEY_O:        ++u;    break;
              case    KEY_N:        ++u;    break;
              case    KEY_M:        ++u;    break;
              case    KEY_L:        ++u;    break;
              case    KEY_K:        ++u;    break;
              case    KEY_J:        ++u;    break;
              case    KEY_I:        ++u;    break;
              case    KEY_H:        ++u;    break;
              case    KEY_G:        ++u;    break;
              case    KEY_F:        ++u;    break;
              case    KEY_E:        ++u;    break;
              case    KEY_D:        ++u;    break;
              case    KEY_C:        ++u;    break;
              case    KEY_B:        ++u;    break;
              case    KEY_A:        u +=3D3;    // A =3D>  4
                evkeyb->btcode =3D 0xA1;
                evkeyb->rep_id =3D REPORTID_KEYBD;
                if ( inevent->value =3D=3D 1 )
                {
                    // "Key down": Add to list of
                    // currently pressed keys
                    for ( j =3D 0; j < 8; ++j )
                    {
                        if (pressedkey[j] =3D=3D 0)
                        {
                        pressedkey[j]=3Du;
                        j =3D 8;
                        }
                        else if(pressedkey[j] =3D=3D u)
                        {
                        j =3D 8;
                        }
                    }
                }
                else if ( inevent->value =3D=3D 0 )
                {    // KEY UP: Remove from array
                    for ( j =3D 0; j < 8; ++j )
                    {
                        if ( pressedkey[j] =3D=3D u )
                        {
                        while ( j < 7 )
                        {
                            pressedkey[j] =3D
                            pressedkey[j+1];
                            ++j;
                        }
                        pressedkey[7] =3D 0;
                        }
                    }
                }
                else    // "Key repeat" event
                {
                    ; // This should be handled
                    // by the remote side, not us.
                }
                memcpy ( evkeyb->key, pressedkey, 8 );
                evkeyb->modify =3D modifierkeys;
                if ( ! connectionok ) break;
                j =3D send ( sockdesc, evkeyb,
                    sizeof(struct hidrep_keyb_t),
                    MSG_NOSIGNAL );
                if ( 1 > j )
                {
                    // If sending data fails,
                    // abort connection
                    return    -1;
                }
                break;
              default:
                // Unknown key usage - ignore that
                ;
                break;
            }
            break;
          // *** Mouse movement events
          case    EV_REL:
            switch ( inevent->code )
            {
              case    ABS_X:
              case    ABS_Y:
              case    ABS_Z:
              case    REL_WHEEL:
                evmouse->btcode =3D 0xA1;
                evmouse->rep_id =3D REPORTID_MOUSE;
                evmouse->button =3D mousebuttons & 0x07;
                evmouse->axis_x =3D
                    ( inevent->code =3D=3D ABS_X ?
                      inevent->value : 0 );
                evmouse->axis_y =3D
                    ( inevent->code =3D=3D ABS_Y ?
                      inevent->value : 0 );
                evmouse->axis_z =3D
                    ( inevent->code >=3D ABS_Z ?
                      inevent->value : 0 );
                if ( ! connectionok ) break;
                j =3D send ( sockdesc, evmouse,
                    sizeof(struct hidrep_mouse_t),
                    MSG_NOSIGNAL );
                if ( 1 > j )
                {
                    return    -1;
                }
                break;
            }
            break;
          // *** Various events we do not know. Ignore those.
          case    EV_ABS:
          case    EV_MSC:
          case    EV_LED:
          case    EV_SND:
          case    EV_REP:
          case    EV_FF:
          case    EV_PWR:
          case    EV_FF_STATUS:
            break;
        }
    }
    return    0;
}

int    main ( int argc, char ** argv )
{
    int            i,  j;
    int            sockint, sockctl; // For the listening sockets
    struct sockaddr_l2    l2a;
    socklen_t        alen=3Dsizeof(l2a);
    int            sint,  sctl;      // For the one-session-only
                          // socket descriptor handles
    char            badr[40];
    fd_set            fds;          // fds for listening sockets
    fd_set            efds;              // dev-event file descriptors
    int            maxevdevfileno;
    char            skipsdp =3D 0;      // On request, disable SDPreg
    struct timeval        tv;          // Used for "select"
    int            onlyoneevdev =3D -1;// If restricted to using only one
evdev
    int            mutex11 =3D 0;      // try to "mute" in x11?
    char            *fifoname =3D NULL; // Filename for fifo, if applicable
    // Parse command line
    for ( i =3D 1; i < argc; ++i )
    {
        if ( ( 0 =3D=3D strcmp ( argv[i], "-h"     ) ) ||
             ( 0 =3D=3D strcmp ( argv[i], "-?"     ) ) ||
             ( 0 =3D=3D strcmp ( argv[i], "--help" ) ) )
        {
            showhelp();
            return    0;
        }
        else if ( ( 0 =3D=3D strcmp ( argv[i], "-s" ) ) ||
              ( 0 =3D=3D strcmp ( argv[i], "--skipsdp" ) ) )
        {
            skipsdp =3D 1;
        }
        else if ( 0 =3D=3D strncmp ( argv[i], "-e", 2 ) ) {
            onlyoneevdev =3D atoi(argv[i]+2);
            fprintf(stdout,"Type E\n");
        }
        else if ( 0 =3D=3D strcmp ( argv[i], "-l" ) )
        {
            return list_input_devices();
        }
        else if ( 0 =3D=3D strcmp ( argv[i], "-d" ) )
        {
            debugevents =3D 0xffff;
        }
        else if ( 0 =3D=3D strcmp ( argv[i], "-x" ) )
        {
            mutex11 =3D 1;
            fprintf(stdout,"Type X\n");
        }
        else if ( 0 =3D=3D strncmp ( argv[i], "-f", 2 ) )
        {
            fifoname =3D argv[i] + 2;
        }
        else
        {
            fprintf ( stderr, "Invalid argument: \'%s\'\n", argv[i]);
            return    1;
        }
    }
    if ( ! skipsdp )
    {
        if ( dosdpregistration() )
        {
            fprintf(stderr,"Failed to register with SDP server\n");
            return    1;
        }
    }
    if ( NULL =3D=3D fifoname )
    {
        if ( 1 > initevents (onlyoneevdev, mutex11) )
        {
            fprintf ( stderr, "Failed to open event interface files\n" );
            return    2;
        }
    } else {
        if ( 1 > initfifo ( fifoname ) )
        {
            fprintf ( stderr, "Failed to create/open fifo [%s]\n", fifoname
);
            return    2;
        }
    }
    maxevdevfileno =3D add_filedescriptors ( &efds );
    if ( maxevdevfileno <=3D 0 )
    {
        fprintf ( stderr, "Failed to organize event input.\n" );
        return    13;
    }
    sockint =3D socket ( AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP );
    sockctl =3D socket ( AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP );
    if ( ( 0 > sockint ) || ( 0 > sockctl ) )
    {
        fprintf ( stderr, "Failed to generate bluetooth sockets\n" );
        return    2;
    }
    if ( btbind ( sockint, PSMHIDINT ) || btbind ( sockctl, PSMHIDCTL ))
    {
        fprintf ( stderr, "Failed to bind sockets (%d/%d) "
                "to PSM (%d/%d)\n",
                sockctl, sockint, PSMHIDCTL, PSMHIDINT );
        return    3;
    }
    if ( listen ( sockint, 1 ) || listen ( sockctl, 1 ) )
    {
        fprintf ( stderr, "Failed to listen on int/ctl BT socket\n" );
        close ( sockint );
        close ( sockctl );
        return    4;
    }
    // Add handlers to catch signals:
    // All do the same, terminate the program safely
    // Ctrl+C will be ignored though (SIGINT) while a connection is active
    signal ( SIGHUP,  &onsignal );
    signal ( SIGTERM, &onsignal );
    signal ( SIGINT,  &onsignal );
    fprintf ( stdout, "The HID-Client is now ready to accept connections "
            "from another machine\n" );
    //i =3D system ( "stty -echo" );    // Disable key echo to the console
    while ( 0 =3D=3D prepareshutdown )
    {    // Wait for any shutdown-event to occur
        sint =3D sctl =3D 0;
        add_filedescriptors ( &efds );
        tv.tv_sec  =3D 0;
        tv.tv_usec =3D 0;
        while ( 0 < (j =3D select(maxevdevfileno+1,&efds,NULL,NULL,&tv)))
        {    // Collect and discard input data as long as available
            fprintf(stderr,"First Parse\n");
            if ( -1 >  ( j =3D parse_events ( &efds, 0 ) ) )
            {    // LCtrl-LAlt-PAUSE - terminate program
                prepareshutdown =3D 1;
                break;
            }
            add_filedescriptors ( &efds );
            tv.tv_sec  =3D 0;
            tv.tv_usec =3D 500; // minimal delay
        }
        if ( prepareshutdown )
            break;
        connectionok =3D 0;
        tv.tv_sec  =3D 1;
        tv.tv_usec =3D 0;
        FD_ZERO ( &fds );
        FD_SET  ( sockctl, &fds );
        j =3D select ( sockctl + 1, &fds, NULL, NULL, &tv );
        if ( j < 0 )
        {
            if ( errno =3D=3D EINTR )
            {    // Ctrl+C ? - handle that elsewhere
                continue;
            }
            fprintf ( stderr, "select() error on BT socket: %s! "
                    "Aborting.\n", strerror ( errno ) );
            return    11;
        }
        if ( j =3D=3D 0 )
        {    // Nothing happened, check for shutdown req and retry
            if ( debugevents & 0x2 )
                fprintf ( stdout, "," );
            continue;
        }
        sctl =3D accept ( sockctl, (struct sockaddr *)&l2a, &alen );
        if ( sctl < 0 )
        {
            if ( errno =3D=3D EAGAIN )
            {
                continue;
            }
            fprintf ( stderr, "Failed to get a control connection:"
                    " %s\n", strerror ( errno ) );
            continue;
        }
        tv.tv_sec  =3D 3;
        tv.tv_usec =3D 0;
        FD_ZERO ( &fds );
        FD_SET  ( sockint, &fds );
        j =3D select ( sockint + 1, &fds, NULL, NULL, &tv );
        if ( j < 0 )
        {
            if ( errno =3D=3D EINTR )
            {    // Might have been Ctrl+C
                close ( sctl );
                continue;
            }
            fprintf ( stderr, "select() error on BT socket: %s! "
                    "Aborting.\n", strerror ( errno ) );
            return    12;
        }
        if ( j =3D=3D 0 )
        {
            fprintf ( stderr, "Interrupt connection failed to "
                    "establish (control connection already"
                    " there), timeout!\n" );
            close ( sctl );
            continue;
        }
        sint =3D accept ( sockint, (struct sockaddr *)&l2a, &alen );
        if ( sint < 0 )
        {
            close ( sctl );
            if ( errno =3D=3D EAGAIN )
                continue;
            fprintf ( stderr, "Failed to get an interrupt "
                    "connection: %s\n", strerror(errno));
            continue;
        }
        ba2str ( &l2a.l2_bdaddr, badr );
        badr[39] =3D 0;
        fprintf ( stdout, "Incoming connection from node [%s] "
                "accepted and established.\n", badr );
        tv.tv_sec  =3D 0;
        tv.tv_usec =3D 0;
        j =3D -1;
        add_filedescriptors ( &efds );
        while ( 0 < (j =3D select(maxevdevfileno+1,&efds,NULL,NULL,&tv)))
        {
            // This loop removes all input garbage that might be
            // already in the queue
            fprintf(stderr,"Second Parse\n");
            if ( -1 > ( j =3D parse_events ( &efds, 0 ) ) )
            {    // LCtrl-LAlt-PAUSE - terminate program
                prepareshutdown =3D 1;
                break;
            }
            add_filedescriptors ( &efds );
            tv.tv_sec  =3D 0;
            tv.tv_usec =3D 0;
        }
        if ( prepareshutdown )
            break;
        connectionok =3D 1;
        memset ( pressedkey, 0, 8 );
        modifierkeys =3D 0;
        mousebuttons =3D 0;
        while ( connectionok )
        {
            add_filedescriptors ( &efds );
            tv.tv_sec  =3D 1;
            tv.tv_usec =3D 0;
            while ( 0 < ( j =3D select ( maxevdevfileno + 1, &efds,
                            NULL, NULL, &tv ) ) )
            {
                fprintf(stderr,"Third Parse\n");
                if ( 0 > ( j =3D parse_events ( &efds, sint ) ) )
                {
                    // PAUSE pressed - close connection
                    connectionok =3D 0;
                    if ( j < -1 )
                    {    // LCtrl-LAlt-PAUSE - terminate
                        close ( sint );
                        close ( sctl );
                        prepareshutdown =3D 1;
                    }
                    break;
                }
                add_filedescriptors ( &efds );
                tv.tv_sec  =3D 1;
                tv.tv_usec =3D 0;
            }
        }
        connectionok =3D 0;
        close ( sint );
        close ( sctl );
        sint =3D sctl =3D  0;
        fprintf ( stderr, "Connection closed\n" );
        usleep ( 500000 ); // Sleep 0.5 secs between connections
                   // to not be flooded
    }
    //i =3D system ( "stty echo" );       // Set console back to normal
    close ( sockint );
    close ( sockctl );
    if ( ! skipsdp )
    {
        sdpunregister ( sdphandle ); // Remove HID info from SDP server
    }
    if ( NULL =3D=3D fifoname )
    {
        closeevents ();
    } else {
        closefifo ();
    }
    cleanup_stdin ();       // And remove the input queue from stdin
    fprintf ( stderr, "Stopped hidclient.\n" );
    return    0;
}


void    showhelp ( void )
{
    fprintf ( stdout,
"hidclient  -  Virtual Bluetooth Mouse and Keyboard\n\n" \
"hidclient allows you to emulate a bluetooth HID device, based on the\n" \
"Bluez Bluetooth stack for Linux.\n\n" \
"The following command-line parameters can be used:\n" \
"-h|-?        Show this information\n" \
"-e<num>\t    Use only the one event device numbered <num>\n" \
"-f<name>    Use fifo <name> instead of event input devices\n" \
"-l        List available input devices\n" \
"-x        Disable device in X11 while hidclient is running\n" \
"-s|--skipsdp    Skip SDP registration\n" \
"        Do not register with the Service Discovery Infrastructure\n" \
"        (for debug purposes)\n\n" \
"Using hidclient in conjunction with \'openvt\' is recommended to minize\n"
\
"impact of keystrokes meant to be transmitted to the local user
interface\n" \
"(like running hidclient from a xterm window). You can make \'openvt\'\n" \
"spawn a text mode console, switch there and run hidclient with the\n" \
"following command line:\n" \
"        openvt -s -w hidclient\n" \
"This will even return to your xsession after hidclient terminates.\n\n" \
"hidclient connections can be dropped at any time by pressing the PAUSE\n" =
\
"key; the program will wait for other connections afterward.\n" \
"To stop hidclient, press LeftCtrl+LeftAlt+Pause.\n"
        );
    return;
}

void    onsignal ( int i )
{
    // Shutdown should be done if:
    switch ( i )
    {
      case    SIGINT:
        if ( 0 =3D=3D connectionok )
        {
            // No connection is active and Ctrl+C is pressed
            prepareshutdown =3D 2;
        }
        else
        {    // Ctrl+C ignored while connected
            // because it might be meant for the remote
            return;
        }
        break;
      case    SIGTERM:
      case    SIGHUP:
        // If a signal comes in
        prepareshutdown =3D 1;
        fprintf ( stderr, "Got shutdown request\n" );
        break;
    }
    return;
}

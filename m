Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimGmce2EqNMBS0qURCnfFFLtdTm7KttwdojDBZL@mail.gmail.com>
References: <AANLkTimGmce2EqNMBS0qURCnfFFLtdTm7KttwdojDBZL@mail.gmail.com>
Date: Wed, 22 Sep 2010 13:42:18 -0700
Message-ID: <AANLkTi=iUhF_umKK08paWDHtpirc60cWGKnQAjsvzkuE@mail.gmail.com>
Subject: Fwd: Gumstix Overo running OE 2.6.34 Bluetooth Serial Device;
 Problem: cannot open /dev/rfcomm0: Connection refused or No such file or directory
From: Paul Matz <paul@osterhoutgroup.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In addition to minicom failing to be able to open /dev/rfcomm0 (see
details below), we also noticed that rfcomm connect fails with this:

Can't connect RFCOMM socket: Connection refused

However, think I found something;  https://bugs.archlinux.org/task/4930

    Details

    bluez changed the pin_helper concept in the last release. If
pairing with a device requires a PIN, then it will send a
dbus-message.
    Unfortunately, there are currently no dbus helpers compatible with
the new bluez dbus API.

    There is a small program called passkey-agent in the bluez-utils
source, which solves this problem.
    If you call "passkey-agent --default <pin>" just before the
pairing attempt, it will use the right pin.

    This program is built with bluez-utils, but make install ignores it.

    Fix: Add install -D -m755
$startdir/src/bluez-utils-3.1/hcid/passkey-agent
$startdir/pkg/usr/bin/passkey-agent to the PKGBUILD.

In bluez-4.71 (bluez4), there appears to be no more utils release;
(last one was bluez-utils-3.36).
Looking thru the source right now to see if there's some sort of
equivalent utility.
Anybody know what's up in the most recent release of bluez?
Thanks in advance,
-PEM

---------- Forwarded message ----------
From: Paul Matz <paul@osterhoutgroup.com>
Date: Mon, Sep 20, 2010 at 1:11 PM
Subject: Overo running OE 2.6.34 Bluetooth Serial Device; Problem:
cannot open /dev/rfcomm0: Connection refused or No such file or
directory
To: gumstix-users@lists.sourceforge.net


We are trying to read input from a Bluetooth embedded serial device.
We are using the bluez4-4.66-r7.0 stack in Open Embedded 2.6.34.
We have been assuming that once the serial BT device pairs and
connects, that we can use rfcomm to map it to a /dev/rfcomm0 serial
device that we can open and read.
The BT serial device is sending data out continuously.  We find that
we can pair it with other systems - Windows for example - and see
serial data blasting out of it.
A lot works, but not enough.  Unsure if pairing is happening
successfully.  Can't seem to get debug info to turn on,  (Tried
launching bluetoothd with -d, but doesn't seem to help).
Here's what we see.
root@overo:~# hcitool scan
Scanning ...
        34:15:9E:90:D9:E6       ODG10050
        00:12:A1:B0:5B:4A       SPP-B
root@overo:~# hcitool inq
Inquiring ...
        34:15:9E:90:D9:E6       clock offset: 0x4129    class: 0x38010c
        00:12:A1:B0:5B:4A       clock offset: 0x3305    class: 0x001f00
(The serial device, SPP-B, does have a weird class; not sure if this
is OK or not).
root@overo:~# hciconfig -a
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 00:19:88:39:F3:90  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:1419 acl:0 sco:0 events:51 errors:0
        TX bytes:389 acl:0 sco:0 commands:26 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'overo-0'
        Class: 0x4a0100
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Uncategorized
        HCI Version: 2.0 (0x3)  Revision: 0xc5c
        LMP Version: 2.0 (0x3)  Subversion: 0xc5c
        Manufacturer: Cambridge Silicon Radio (10)

root@overo:~# hcitool info 00:12:A1:B0:5B:4A
Requesting information ...
        BD Address:  00:12:A1:B0:5B:4A
        Device Name: SPP-B
        LMP Version: 2.0 (0x3) LMP Subversion: 0x10b7
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>
root@overo:~# rfcomm bind 0
root@overo:~# rfcomm
rfcomm0: 00:12:A1:B0:5B:4A channel 2 clean
Processes running of interest:
  PID TTY      STAT   TIME COMMAND
  874 ?        S      0:00 /usr/sbin/hciattach -s 115200 ttyS1 csr 115200 noflow
  878 ?        S<s    0:00 /usr/sbin/bluetoothd --udev
  884 ?        S      0:00 /usr/bin/rfcomm -r watch 0 1 /sbin/getty -w -L rfcomm
Devices of interest:
root@overo:~# ls -alFgt /dev | head
crw-------  1 tty       4,  66 Sep  2 20:33 ttyS2
crw-------  1 root      4,  12 Sep  2 20:33 tty12
crw-rw----  1 users   216,   0 Sep  2 20:23 rfcomm0
crw--w--w-  1 root      4,   1 Sep  2 20:03 tty1
crw-------  1 root      5,   1 Sep  2 20:03 console
crw-rw----  1 dialout   4,  65 Sep  2 20:03 ttyS1
Trying to attach to it using minicom fails:
root@overo:~# minicom
minicom: cannot open /dev/rfcomm0: Connection refused
(sometimes the error is minicom: cannot open /dev/rfcomm0: No such
file or directory)
The suspicion is that we don't have the default pin configured
correctly, even though we've put it into the right file.
When security mode is set to user, there is suppose to be prompting
for the pin, but this doesn't work.

Attached below are some of the configuration files we have set up:
/etc/default/bluetooth :

HCIATTACH_ENABLE=true
HCIATTACH_TTY=ttyS1
HCIATTACH_TYPE=csr
HCIATTACH_START_SPEED=115200
HCIATTACH_SPEED=115200
HCIATTACH_HANDSHAKE=noflow
HCID_ENABLE=true
HCID_CONFIG="/etc/bluetooth/hcid.conf"
SDPD_ENABLE=true
HIDD_ENABLE=false
#HIDD_OPTIONS=""
HID2HCI_ENABLE=true
RFCOMM_ENABLE=true
RFCOMM_CONFIG="/etc/bluetooth/rfcomm.conf"
DUND_ENABLE=false
DUND_OPTIONS="--listen --persist"
PAND_ENABLE=false
#PAND_OPTIONS="--listen --role NAP"
#PAND_OPTIONS="--role PANU --search --service NAP -sdp --persist"

/etc/bluetooth/hcid.conf:

options {
autoinit yes;
security none;           # tried auto & user here too...
pairing multi;
passkey "0000";
}
device {
name "%h-%d";
class 0x3e0100;
#pkt_type DH1,DM1,HV1;
iscan enable; pscan enable;
lm accept,master;
lp rswitch,hold,sniff,park;
}
device 00:12:A1:B0:5B:4A {
name "SPP-B"
}

/etc/bluetooth/rfcomm.conf:

rfcomm0 {
        bind yes;
        device 00:12:A1:B0:5B:4A;
        channel 2;
        comment "9 axis contoller Bluetooth device";
}

/etc/bluetooth/main.conf:

[General]
Name = %h-%d
Class = 0x000100
DiscoverableTimeout = 0
PairableTimeout = 0
PageTimeout = 8192
DiscoverSchedulerInterval = 0
InitiallyPowered = true
RememberPowered = true
#DeviceID = 1234:5678:abcd
ReverseServiceDiscovery = true
NameResolving = true
DebugKeys = false

--
Regards,
Paul Matz
Director, Software & Architecture
Osterhout Design Group - 153 Townsend St., STE 570, SF, CA 94107
Desk: 415 644 4030  Cell: 415 652 4077





--
Regards,
Paul Matz
Director, Software & Architecture
Osterhout Design Group - 153 Townsend St., STE 570, SF, CA 94107
Desk: 415 644 4030  Cell: 415 652 4077

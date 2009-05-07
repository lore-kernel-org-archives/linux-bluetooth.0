Return-Path: <cyrus@holtmann.org>
Message-ID: <363123.87568.qm@web95416.mail.in2.yahoo.com>
References: <5d223510905060754p70b53725u52963a0b41c82788@mail.gmail.com>
Date: Thu, 7 May 2009 08:18:21 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: HSP and HFP no sound
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <5d223510905060754p70b53725u52963a0b41c82788@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Rafael ,

root@debian:/var/log# bluetoothd -dn
bluetoothd[1535]: Bluetooth daemon
bluetoothd[1535]: Enabling debug information
bluetoothd[1535]: parsing main.conf
bluetoothd[1535]: discovto=0
bluetoothd[1535]: pairto=0
bluetoothd[1535]: pageto=8192
bluetoothd[1535]: name=Sheeva
bluetoothd[1535]: class=0x100204
bluetoothd[1535]: inqmode=0
bluetoothd[1535]: Key file does not have key 'DeviceID'
bluetoothd[1535]: Unable to get on D-Bus



>From above log message , daemon is not able to get dbus instance because another bluetooth daemon is already running .
so stop the already running bluetooth dameon by service stop bluetooth 
then start bluetooth -d -n

Please share your output 
Thanks,
Balaji.P


----- Original Message ----
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sent: Wednesday, 6 May, 2009 8:24:41 PM
Subject: HSP and HFP no sound

Hi

I'm trying to make bluetooth work in a embedded hw its an arm. I'm
using HSP and HFP.
I can scan, pair, make and receive calls but I can hear no sound in
both directions.

I'm posting some information:

root@debian:/var/log# uname -a
Linux debian 2.6.22.18 #3 Tue May 5 15:51:47 BRT 2009 armv5tejl GNU/Linux

root@debian:/var/log# apt-cache policy bluez
bluez:
  Installed: 4.32-0ubuntu4
  Candidate: 4.32-0ubuntu4
  Version table:
*** 4.32-0ubuntu4 0
        500 http://ports.ubuntu.com jaunty/main Packages
        100 /var/lib/dpkg/status

root@debian:/var/log# vi syslog
May  6 09:34:53 debian kernel: usb 1-1: new full speed USB device
using ehci_marvell and address 3
May  6 09:34:53 debian kernel: usb 1-1: configuration #1 chosen from 1 choice
May  6 09:34:53 debian bluetoothd[1235]: HCI dev 0 registered
May  6 09:34:54 debian bluetoothd[1235]: HCI dev 0 up
May  6 09:34:54 debian bluetoothd[1235]: Starting security manager 0
May  6 09:34:54 debian bluetoothd[1235]: rfcomm_bind: Address already
in use (98)
May  6 09:34:54 debian bluetoothd[1235]: audio-headset: Operation not
permitted (1)
May  6 09:34:54 debian bluetoothd[1235]: l2cap_bind: Address already in use (98)
May  6 09:34:54 debian bluetoothd[1235]: audio-a2dp: Operation not permitted (1)
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.SerialProxyManager on path /org/bluez/1235/hci0
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.Service on path /org/bluez/1235/hci0
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.Control on path /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.Serial on path /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
May  6 09:34:54 debian bluetoothd[1235]: probe failed with driver
input-headset for device /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.Control on path /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
May  6 09:34:54 debian bluetoothd[1235]: Registered interface
org.bluez.Serial on path /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
May  6 09:34:54 debian bluetoothd[1235]: probe failed with driver
input-headset for device /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
May  6 09:34:54 debian bluetoothd[1235]: Adapter /org/bluez/1235/hci0
has been enabled
May  6 09:34:54 debian bluetoothd[1235]: Failed to access HAL

root@debian:/var/log# hciconfig -a
hci0:   Type: USB
        BD Address: 00:19:5D:0F:53:07 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN
        RX bytes:4082 acl:51 sco:0 events:157 errors:0
        TX bytes:1715 acl:52 sco:0 commands:72 errors:0
        Features: 0xff 0x3e 0x85 0x30 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Sheeva'
        Class: 0x480204
        Service Classes: Capturing, Telephony
        Device Class: Phone, Cellular
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
        Manufacturer: Integrated System Solution Corp. (57)


root@debian:/var/log# hciconfig hci0 voice
hci0:   Type: USB
        BD Address: 00:19:5D:0F:53:07 ACL MTU: 672:3 SCO MTU: 48:1
        Voice setting: 0x0060 (Default Condition)
        Input Coding: Linear
        Input Data Format: 2's complement
        Input Sample Size: 16 bit
        # of bits padding at MSB: 0

root@debian:/var/log# bluetoothd -dn
bluetoothd[1535]: Bluetooth daemon
bluetoothd[1535]: Enabling debug information
bluetoothd[1535]: parsing main.conf
bluetoothd[1535]: discovto=0
bluetoothd[1535]: pairto=0
bluetoothd[1535]: pageto=8192
bluetoothd[1535]: name=Sheeva
bluetoothd[1535]: class=0x100204
bluetoothd[1535]: inqmode=0
bluetoothd[1535]: Key file does not have key 'DeviceID'
bluetoothd[1535]: Unable to get on D-Bus



-- 
Rafael S. Seste
Eng Computação - Unicamp
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com


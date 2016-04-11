Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Stuart Little <Stuart.Little@leotel-software.co.uk>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bluetoothctl - no default controller
Date: Mon, 11 Apr 2016 12:43:08 +0000
Message-ID: <75ddd5f4b27343aeaf4c454d8a228b3d@EX2013.leotel.co.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  Basically cannot see any beacons when performing hcitool lescan.

  hciconfig:-
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 78:A5:04:25:57:51  ACL MTU: 1021:6  SCO MTU: 180:4
        UP RUNNING
        RX bytes:1216 acl:0 sco:0 events:47 errors:0
        TX bytes:502 acl:0 sco:0 commands:47 errors:0

Rfkill list
0: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

systemctl|grep Bluetooth:-
sys-devices-virtual-bluetooth-hci0-rfkill0.device         loaded active plugged   /sys/devices/virtual/bluetooth/hci0/rfkill0
sys-devices-virtual-bluetooth-hci0.device                      loaded active plugged   /sys/devices/virtual/bluetooth/hci0
sys-subsystem-bluetooth-devices-hci0.device             loaded active plugged   /sys/subsystem/bluetooth/devices/hci0
bluetooth.service                                                                      loaded active running   Bluetooth service
bluetooth.target                                                                        loaded active active    Bluetooth

However bluetoothctl just shows 'No default controller available'.
Using Jessie 8.4 over 2 kernels, 3.14.48 & 4.3.4. The 3.14.48 kernel is known to work, but for various reasons cannot be updated at present. 

Stu

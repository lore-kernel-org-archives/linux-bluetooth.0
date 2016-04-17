Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Stuart Little <Stuart.Little@leotel-software.co.uk>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: gatttool unable to connect to LE device, connection refused (111)
Date: Sun, 17 Apr 2016 16:15:07 +0000
Message-ID: <b34adead8bf54247ba80dd74ecee1d26@EX2013.leotel.co.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
  Using linux kernel 4.2.8 or 4.3.4 I have been unable to connect to BLE devices using either gatttool or our app, which worked on an earlier kernel but had reliability issues so we have been updating to later kernel and rootfs.

hciconfig  shows 

hci0:   Type: BR/EDR  Bus: UART
        BD Address: 78:A5:04:31:3C:4B  ACL MTU: 1021:6  SCO MTU: 180:4
        UP RUNNING
        RX bytes:24625 acl:0 sco:0 events:733 errors:0
        TX bytes:481 acl:0 sco:0 commands:43 errors:0

Hcitool lescan:-

LE Scan ...
DA:61:22:17:65:E8 (unknown)
DA:61:22:17:65:E8 (unknown)
C3:9B:9C:19:F8:49 (unknown)
C3:9B:9C:19:F8:49 (unknown)

The application scan also receives beacons, however when an attempt to connect is made either via the app or gatttool I always get connection refused (111).

systemctl | grep Bluetooth

sys-devices-virtual-bluetooth-hci0-rfkill0.device            loaded active plugged   /sys/devices/virtual/bluetooth/hci0/rfkill0
sys-devices-virtual-bluetooth-hci0.device                         loaded active plugged   /sys/devices/virtual/bluetooth/hci0
sys-subsystem-bluetooth-devices-hci0.device                loaded active plugged   /sys/subsystem/bluetooth/devices/hci0
bluetooth.service                                                                         loaded active running   Bluetooth service
bluetooth.target                                                                           loaded active active    Bluetooth

bluetoothctl howver shows No default controller availalble.


One post suggested that bluez does not support BLE without a configuration change using btmgmt le on, but that fails 
"Set Low Energy for hci0 failed with status 0x11 (Invalid Index)", presumably as bluetoothd has no controller.

Any pointers as to what I am missing (bluetooth newbie)

Thanks,
  Stu


 



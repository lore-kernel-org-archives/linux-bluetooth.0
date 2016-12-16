Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
To: "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth 6lowpan ping6 slab corruption
Date: Fri, 16 Dec 2016 06:46:07 +0000
Message-ID: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have enabled 6lowpan and bluetooth 6lowpan in the kernel configuration on two systems. Both these systems are running linux and one act as a master and another act as a slave.
I am facing a bug while in a bluetooth 6lowpan connection. This happens during a ping6. The kernel version that I am using is 4.1.27 with BlueZ 5.40 on a x86_64 architecture. The kernel reports regarding slab corruption.

The steps that I have performed are as follows:
Slave device:
$ modprobe 6lowpan
$ modprobe Bluetooth_6lowpan
$ echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
$ hciconfig hci0 leadv 

Master device:
$ modprobe 6lowpan
$ modprobe bluetooth_6lowpan
$ echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
$ hcitool lescan << to obtain slave BT ADDR
$ echo "connect <remote_BT_MAC> 1" > /sys/kernel/debug/bluetooth/6lowpan_control
$ ifconfig (look for bt0 interface) << to obtain IPv6 address of slave device
$ ping6 -I bt0 <IPV6_ADDR>     <<<<------ The console message starts to appear here during ping6

The output of the console message:

[  794.985623] Slab corruption (Tainted: G     U         ): skbuff_head_cache start=ffff8801f568f700, len=232
[  795.008755] 050: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  ....kkkkkkkkkkkk
[  795.029380] Prev obj: start=ffff8801f568f600, len=232
[  795.044743] 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  795.061310] 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  795.076752] Next obj: start=ffff8801f568f800, len=232
[  795.088448] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  795.102365] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk

The 6lowpan connection between the two devices is connected.
I observed that the console message appears once when the master initiates the connection to the slave and nothing happens after that.
Once I start doing the ping6 from master to slave, the same message appears again. This same set of message continues to be printed every 5 seconds or so.
This also persists when ping6 is done from the slave to the master. 

Do you know what could possibly cause this issue?

Please let me know if you require further information.

Thank you.

Best regards,
Joshua

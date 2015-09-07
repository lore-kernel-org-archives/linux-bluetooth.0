Return-Path: <cyrus@holtmann.org>
From: Bhuvanchandra <bhuvanchandradv@gmail.com>
Subject: build issues with rtl8723au_bt
To: linux-bluetooth@vger.kernel.org
Cc: Larry.Finger@lwfinger.net, bhuvanchandra.dv@gmail.com
Message-ID: <55ED8120.4060604@gmail.com>
Date: Mon, 7 Sep 2015 17:50:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I'm testing RTL8723BU(available in LM811. USB ID 0bda:b720) WiFi BT USB module.
Kernel version used: 4.1.5. Cross-compiled the Wifi Driver from[1] it worked fine.
While crosscompiling the driver for BT which is available at[2], there are few
compile time errors:
....
make ARCH=arm CROSS_COMPILE=/home/dvb/gcc-linaro/bin/arm-linux-gnueabihf- -C /home/dvb/linux-toradex M=/home/dvb/rtl8723au_bt modules
make[1]: Entering directory '/home/dvb/toradex/linux-toradex/linux-toradex-vf/linux-toradex'
   CC [M]  /home/dvb/rtl8723au_bt/btusb.o
/home/dvb/rtl8723au_bt/btusb.c: In function 'hci_reassembly':
/home/dvb/rtl8723au_bt/btusb.c:376:15: error: 'NUM_REASSEMBLY' undeclared (first use in this function)
       index >= NUM_REASSEMBLY)
                ^
/home/dvb/rtl8723au_bt/btusb.c:376:15: note: each undeclared identifier is reported only once for each function it appears in
/home/dvb/rtl8723au_bt/btusb.c:379:12: error: 'struct hci_dev' has no member named 'reassembly'
   skb = hdev->reassembly[index];
             ^
/home/dvb/rtl8723au_bt/btusb.c:405:7: error: 'struct hci_dev' has no member named 'reassembly'
    hdev->reassembly[index] = skb;
        ^
/home/dvb/rtl8723au_bt/btusb.c:427:10: error: 'struct hci_dev' has no member named 'reassembly'
       hdev->reassembly[index] = NULL;
           ^
/home/dvb/rtl8723au_bt/btusb.c:440:10: error: 'struct hci_dev' has no member named 'reassembly'
       hdev->reassembly[index] = NULL;
           ^
/home/dvb/rtl8723au_bt/btusb.c:453:10: error: 'struct hci_dev' has no member named 'reassembly'
       hdev->reassembly[index] = NULL;
           ^
/home/dvb/rtl8723au_bt/btusb.c:466:8: error: 'struct hci_dev' has no member named 'reassembly'
     hdev->reassembly[index] = NULL;
         ^
scripts/Makefile.build:264: recipe for target '/home/dvb/rtl8723au_bt/btusb.o' failed
make[2]: *** [/home/dvb/rtl8723au_bt/btusb.o] Error 1
Makefile:1384: recipe for target '_module_/home/dvb/rtl8723au_bt' failed
make[1]: *** [_module_/home/dvb/rtl8723au_bt] Error 2
make[1]: Leaving directory '/home/dvb/toradex/linux-toradex/linux-toradex-vf/linux-toradex'
Makefile-custom:22: recipe for target 'all' failed
make: *** [all] Error 2
.....

I also tried the recent branches all got the same errors.
Does any one tested RTL8723BU's bluetooth?

I couldn't find any in-tree driver available for RTL8723BU. Is there anything i'm missing or
doing wrong ?

[1] https://github.com/lwfinger/rtl8723bu
[2] https://github.com/lwfinger/rtl8723au_bt

Best regards,
Bhuvan


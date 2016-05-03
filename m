Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 May 2016 22:36:37 +0900
Message-ID: <CAArnnE5hhFgnJGvd76Bb2z9pDizqHp0WieFnUSPQoKnNbZZpYg@mail.gmail.com>
Subject: Please advice me to use LEAdvertisingManager1 by backport
From: Hyuntak Lee <pphdev12@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dears,

I'm trying to backport a latest bluetooth subsystem to 3.4 kernel to
use the BLE and LEAdvertisingManager1.
I think backport is success, but 'LEAdvertisingManager1 interface not
found' error still occured.

My step is below:

###To compile old kernel
$ export ARCH=arm
$ export CROSS_COMPILE=$CCPREFIX
$ cd $KERNEL_SRC
KERNEL_SRC$ make defconfig
KERNEL_SRC$ make
KERNEL_SRC$ make INSTALL_MOD_PATH=$OUTPUT install
###To backport
$ export KLIB=$KERNEL_SRC
$ export KLIB_BUILD=$OUTPUT
$ wget http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v4.1.1/backports-4.1.1-1.tar.xz
$ unxz backports-4.1.1-1.tar.xz
$ tar xfp backports-4.1.1-1.tar
$ cd backports-4.1.1-1
backports-4.1.1-1$ echo "CPTCFG_BT=m
> CPTCFG_BT_RFCOMM=m
> CPTCFG_BT_BNEP=m
> CPTCFG_BT_BNEP_MC_FILTER=y
> CPTCFG_BT_BNEP_PROTO_FILTER=y" > defconfigs/bluetooth
backports-4.1.1-1$ make defconfig-bluetooth
backports-4.1.1-1$ make
backports-4.1.1-1$ make install
### replaces a existed kernel with $KERNEL_SRC/arch/arm/boot/zImage
### replaces a existed /lib/modules with $OUTPUT/lib/modules
### and execute command 'depmod -a' and reboot
### After reboot, excute test/example-advertisement
### output message is 'LEAdvertisingManager1 interface not found'

Am I missing some configuration or doing wrong step?
or cannot use 'LEAdvertisingManager1' by backport?
Please advise me.

Best regards,
tak

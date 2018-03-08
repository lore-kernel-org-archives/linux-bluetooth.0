Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Manuel Masiello <manuel@foobot.io>
Subject: Bluetoothctl: "write" command only send one byte.
Message-ID: <4043ca82-99c9-d1e9-37ec-3e484ad09250@foobot.io>
Date: Thu, 8 Mar 2018 18:11:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody,

I write to the community because I have a problem using Bluetoothctl.
I am looking to write in an attribute with the gatt command "Write".

Here is my command line operation suite:

$ bluetoothctl

[bluetooth]# power on
[bluetooth]# connect A6:41:29:67:30:ED
[my_device]# menu gatt
[my_device]# select-attribute 
/org/bluez/hci0/dev_A6_41_29_67_30_ED/service0034/char0035
[my_device:/service0034/char0035]# write 0x41 0x54 0x2b 0x4e 0x69 0x6d 
0x70 0x00

This is where I have a problem. I never get an error message but the BLE 
device only receive the 1st byte 0x41.
However, using Android applications like LightBlue or nRF Connect, it 
receives correctly what I seek sent.
I scanned the net without finding an answer. I do not really understand 
why it does not work ...


For information:
Linux version 4.13.0-36-generic (buildd@lcy01-amd64-017) (gcc version 
7.2.0 (Ubuntu 7.2.0-8ubuntu3.2)) #40-Ubuntu SMP Fri Feb 16 20:07:48 UTC 2018

I only have "Bluetoothctl" to do the job because the Alpine Linux 
distribution contains nothing else:
https://pkgs.alpinelinux.org/contents?file=&path=&name=bluez&branch=edge&repo=main&arch=x86

Is there anyone who can help me find my mistake?


Best regards,
Manuel

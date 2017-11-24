Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ilyas Keskin <ilyask92@gmx.de>
Subject: Read configuration from bluetooth remote control
To: linux-bluetooth@vger.kernel.org
Message-ID: <b78505b5-a5f3-e93d-fc03-f4bc7a74f298@gmx.de>
Date: Fri, 24 Nov 2017 13:49:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am currently working on emulating a remote control unit using the 
raspberry pi 3s onboard bluetooth/wifi chip.
I already installed bluez-stack and played around with 
bluetoothctl/hcitool but could really establish a proper connection

The chips used are:

STB - Broadcom BCM43602KMLG (BT Classic)
RCU - Broadcom BCM20734UA1

Steps I tried: bluetoothctl --> power on --> agent on --> scan on --> 
scan off --> devices. Unfortunately the STBs BT MAC address is not shown 
there. Another problem is that the STB is running some kind of ARMv7l 
Linux distro with proprietary BT implementation and I have not yet been 
able to find the BT MAC address nor the actual BT stack implementation.

My guess here is that the STB is expecting some special authentication 
by the RCU.

So my question is if there is the possiblity to read that 
config/auth-information from the RCU and then spoof it using the rpi3.
I think of something close to the process of "porgramming" one of these 
old IR-remotes which read key map from TVs.


Best regards,


Ilyas Keskin


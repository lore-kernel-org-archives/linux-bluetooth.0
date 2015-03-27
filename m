Return-Path: <cyrus@holtmann.org>
Message-ID: <5515ECE9.9080101@gmail.com>
Date: Sat, 28 Mar 2015 00:51:05 +0100
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Nexus 4 in BLE peripheral role with bluez stack
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I recently built an autonomous bluetooth LE network (based on Nordic 
nRF51822 central/nRF8001 peripheral µC) which I use for basic home 
automation tasks.

To access this network from my Nexus 4 I need to put the phone in a 
peripheral role so it can connect to the nRF51822 central.

As bluedroid won't support older Nexus phones in a peripheral role 
anytime soon and is difficult to hack I was looking into bluez as an 
alternative. I looked through the bluez source over the last few days, 
watched your latest commits and list conversations, read up all kind of 
README's and API docs.

I'm pleased to see that you're actively working on the kernel-side LE 
advertising mgmt API and that you already implemented HAL stubs on the 
Android side for the Lollipop 5.0 peripheral role enhancements.

It seems that the min requirement for peripheral role support in Android 
would be at least 5 concurrent multi-advertising instances.

What is your schedule for the implementation of the multi-advertising 
stubs in the Android bluetoothd HAL daemon? Is someone working on it 
already? Would you welcome patches? (I never contributed to bluez, 
though, and would require a bit of initial 1:1 support...)

Is there still something else missing on the kernel side or in userland 
to make multi-advertisement work? Or is it all just about HAL support now?

Kind regards,

Florian



-- 
Florian Grandel
Freelance Software Developer

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: PROBLEM: 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54A2D333.7090607@gmail.com>
Date: Tue, 30 Dec 2014 11:09:52 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org>
References: <54A2D333.7090607@gmail.com>
To: Miguel Barrio Orsikowsky <megamik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miguel,

> [1.] One line summary of the problem:
> 
> 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
> 
> [2.] Full description of the problem/report:
> 
> The Bluetooth adapter is detected and apparently working but, when executing "hcitool scan", the device list is always empty: it cannot see any BT device around.
> 
> But, if I boot into Windows just before booting into Linux, the adapter works perfectly and it sees all BT devices. It seems Windows driver is performing some activation to the BT adapter.
> 
> Test case:
> Step 1: power on the Sony VAIO SVF1531C5E and boot into Linux.
> Step 2: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see that nothing gets listed.
> Step 4: reboot the laptop and boot into a Windows partition (mine is Windows 8.1 x64).
> Step 5: wait until it is completely booted, then just reboot into Linux again.
> Step 6: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see all of your devices correctly listed this time. You will be able to pair and use them later without any issue.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> 
> [4.] Kernel version (from /proc/version):
> 
> Linux version 3.19.0-031900rc2-generic (apw@tangerine) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201412290135 SMP Mon Dec 29 01:36:54 UTC 2014

just include the content of /sys/kernel/debug/usb/devices for this adapter. I assume it is connected via USB.

Regards

Marcel


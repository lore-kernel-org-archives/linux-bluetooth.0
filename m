Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Loic Poulain <loic.poulain@intel.com>,
        linux-bluetooth@vger.kernel.org
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
Date: Mon, 26 Jun 2017 19:59:25 +0100
MIME-Version: 1.0
In-Reply-To: <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 26/06/17 09:33, Loic Poulain wrote:

> From user-space, you only have to attach your tty with the bcm line 
> discipline. btattach is the preferred way. $ btattach -B /dev/ttyX -P
> bcm
> 
> What is your platform, do you have ACPI or Device-tree support ? any 
> entry corresponding to your bcm controller ?


OK, so it looks like it is capable of loading the firmware - thats a big
step. sadly,

hciconfig hci0 up

results in:

Bluetooth: hci0: BCM: chip id 94
Bluetooth: hci0: BCM (001.002.009) build 0022
Bluetooth: hci0: BCM (001.002.009) build 0022
Can't init device hci0: No such device (19)

however, I can use the old hciattach method to attach to the uart and it
works - thus the firmware is running.

I'll prod this a bit tomorrow - in the meantime, is there a known
current/good firmware for this chip? (43430a)

Thanks,

-Ian

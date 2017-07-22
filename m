Return-Path: <ian@mnementh.co.uk>
Subject: Re: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware
 download
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxin.john@gmail.com,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Andy Duan <fugang.duan@nxp.com>, "Maxin B. John" <maxin.john@intel.com>
References: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
 <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
 <768de172-bf01-e9ea-a4c9-ea8f46cf5f1d@mnementh.co.uk>
 <C7827387-1AD3-41C9-9F1B-FF4A57940AB9@holtmann.org>
 <aee49b83-5191-23c2-45b3-b695fc6d5a9c@mnementh.co.uk>
 <79177492-9A36-4378-A914-A7073C1DD24A@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <58d4171b-287e-2406-135e-e34e166aae41@mnementh.co.uk>
Date: Sat, 22 Jul 2017 17:06:23 +0100
MIME-Version: 1.0
In-Reply-To: <79177492-9A36-4378-A914-A7073C1DD24A@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 21/07/17 12:27, Marcel Holtmann wrote:

>> A far better approach would be to teach ACPI platforms how to chreate
>> their own serdev devices.
> 
> I agree that ACPI and even pure platform devices should create serdev nodes.

Then my driver will work as is (if the irq/sleep dt entries are
implemented. I can do a respin with these added, and it can use the same
DT labels as the Nokia driver does. No need for modifying the old driver
at all.

>> Platforms with zero hardware info available should NOT be using serdev.
> 
> Actually there will be development hardware that comes via USB-TTY converters
> and we need to make this work somehow. I am not going to write two drivers for
> each hardware in the future. And we are using development boards often for
> hardware testing and bringup.

That should work.

I havent looked, but it seems to me that all we need to do is allow
serial port drivers to register a DT structure for the BT subdevice
attached to them when they probe, if such a function doesnt already exist.

I dont see what other glue we would need - perhaps the USB ones might
need a callback to allow them to send USB packets to control the wakeup
lines etc.

-Ian

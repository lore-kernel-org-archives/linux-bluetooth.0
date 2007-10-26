Return-Path: <jikos@jikos.cz>
Date: Fri, 26 Oct 2007 15:29:19 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Simone Malacarne <s.malacarne@gmail.com>
cc: linux-usb-devel@lists.sourceforge.net, bluez-devel@lists.sourceforge.net,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [linux-usb-devel] dmesg warning on hid core
In-Reply-To: <1193350427.11632.8.camel@simo-desktop>
Message-ID: <Pine.LNX.4.64.0710261526020.18815@twin.jikos.cz>
References: <1193350427.11632.8.camel@simo-desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 26 Oct 2007, Simone Malacarne wrote:

> don't know if this is the right place to post this msg. If it's not 
> related sorry for the noise. I see these warnings in my dmesg related to 
> hid-core.c. I'm running Ubuntu Gutsy 64bit version (Linux version 
> 2.6.22-14-generic (buildd@crested) (gcc version 4.1.3 20070929 
> (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP) with a Logitech bluetooth 
> mouse + keyboard.
> [   56.549723] ppdev: user-space parallel port driver
> [   57.088868] audit(1193337315.477:3):  type=1503
> operation="inode_permission" requested_mask="a" denied_mask="a"
> name="/dev/tty" pid=5062 profile="/usr/sbin/cupsd"
> [   58.301241] Failure registering capabilities with primary security
> module.
> [   58.548905] Bluetooth: Core ver 2.11
> [   58.548997] NET: Registered protocol family 31
> [   58.549000] Bluetooth: HCI device and connection manager initialized
> [   58.549003] Bluetooth: HCI socket layer initialized
> [   58.576780] Bluetooth: L2CAP ver 2.8
> [   58.576784] Bluetooth: L2CAP socket layer initialized
> [   58.712747] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   58.761656] WARNING:
> at /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/hid-core.c:777
> implement()
> [   58.761661] 
> [   58.761662] Call Trace:
> [   58.761680]  [<ffffffff881415d8>] :hid:hid_output_report+0x218/0x280
> [   58.761693]  [<ffffffff8814b51c>] :usbhid:hid_submit_ctrl+0x7c/0x260
> [   58.761702]  [<ffffffff8814b859>] :usbhid:usbhid_submit_report
> +0x159/0x210
> [   58.761711]  [<ffffffff8814e1f6>] :usbhid:hiddev_ioctl+0x456/0xb10
> [   58.761720]  [<ffffffff80326971>] __up_read+0x21/0xb0
> [   58.761727]  [<ffffffff8043495b>] do_page_fault+0x3cb/0x870
> [   58.761738]  [<ffffffff8814dda0>] :usbhid:hiddev_ioctl+0x0/0xb10
> [   58.761744]  [<ffffffff802a6e63>] do_ioctl+0x93/0xe0
> [   58.761750]  [<ffffffff802a6f24>] vfs_ioctl+0x74/0x2d0
> [   58.761756]  [<ffffffff802a7215>] sys_ioctl+0x95/0xb0
> [   58.761763]  [<ffffffff80209e8e>] system_call+0x7e/0x83

[... several identical backtraces removed ...]

> [  108.915332] input: Logitech diNovo Keyboard as /class/input/input16
> [  111.469640] input: Logitech MX900 Mouse as /class/input/input17
> [ 3905.201642] input: Logitech MX900 Mouse as /class/input/input18
> [ 4140.456387] input: Logitech diNovo Keyboard as /class/input/input19
> [ 4208.661803] input: Logitech MX900 Mouse as /class/input/input20
> [ 6377.597303] input: Logitech MX900 Mouse as /class/input/input21
> [ 6634.465647] input: Logitech diNovo Keyboard as /class/input/input22

Hi,

the problem is that some userspace utility (I guess hid2hci from 
bluez-utils) issues hiddev ioctl() with inappropriate out-of-bounds value.

As far as I know Logitech bluetooth keyboards are problematic, as Marcel 
doesn't have any specification for them, so switching between HID and HCI 
modes is reverse engineering and guessing.

-- 
Jiri Kosina

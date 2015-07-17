Return-Path: <cyrus@holtmann.org>
Message-ID: <8297c42b69d89cb9326b938a9adaa997.squirrel@mungewell.org>
In-Reply-To: <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
References: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
    <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
Date: Fri, 17 Jul 2015 01:14:22 -0400
Subject: Re: Kernel Oops: btusb:  4.2rc1 System lockup with BT dongle insert
 - log attached
From: simon@mungewell.org
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> [  117.236007]  [<ffffffff814d2ccf>] device_del+0x18f/0x270
> [  117.236007]  [<ffffffff8109b340>] ? wake_up_q+0x70/0x70
> [  117.236007]  [<ffffffff814e97da>] _request_firmware+0x5aa/0xaf0
> [  117.236007]  [<ffffffff814e9d55>] request_firmware+0x35/0x50
> [  117.236007]  [<ffffffffc00fb881>] btbcm_setup_patchram+0x191/0x910
> [btbcm]
> [  117.236007]  [<ffffffff814e0994>] ? rpm_idle+0xc4/0x200
> [  117.236007]  [<ffffffffc0e28488>] hci_dev_do_open+0xd8/0x500

Looking between log from 3.19
--
Jul  7 21:42:57 retrobox kernel: [  107.562441] bluetooth hci0: Direct
firmware load
for brcm/BCM20702A0-0a5c-21e8.hcd failed with error -2
Jul  7 21:42:57 retrobox kernel: [  107.562452] Bluetooth: hci0: BCM: patch
brcm/BCM20702A0-0a5c-21e8.hcd not found
--

And the log of the lockup:
https://www.flickr.com/photos/24244464@N03/19375918529/sizes/o/

It looks like the firmware 'opt_flags' must be different, so this may be a
contributing factor.

In fact I found a log from 4.1.0rc7, which shows they recently changed!!
--
Jul 15 21:17:40 blind-fury kernel: [    0.000000] Linux version 4.1.0-rc7+
(root@blind-fury) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #2 SMP
Wed Jun 10 21:25:17 MDT 2015
Jul 15 21:17:40 blind-fury kernel: [    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-4.1.0-rc7+
root=UUID=56684438-bf61-422a-9c47-e0d7e405f4e7 ro quiet splash
...
Jul 15 21:20:04 blind-fury kernel: [  173.591327] usbcore: registered new
interface driver btusb
Jul 15 21:20:04 blind-fury kernel: [  173.604148] Bluetooth: hci0: BCM:
chip id 63
Jul 15 21:20:04 blind-fury kernel: [  173.606079] Bluetooth: hci0:
BCM20702A1 (001.002.014) build 0000
Jul 15 21:20:04 blind-fury kernel: [  173.628434] bluetooth hci0: Direct
firmware load for brcm/BCM20702A1-0a5c-21e8.hcd failed with error -2
Jul 15 21:20:04 blind-fury kernel: [  173.628439] Bluetooth: hci0: BCM:
Patch brcm/BCM20702A1-0a5c-21e8.hcd not found
--

These are checked here, but code hasn't changed recently:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/firmware_class.c?id=6593d9245bc66e6e3cf4ba6d365a7833110c1402#n1135


There has been changes to the btbcm.c code wrt to firmware loading:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/bluetooth/btbcm.c?id=18aeb4445aa00f6f402ba3a92a2e9ff3d13882b4

Simon.


Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Feb 2012 14:34:24 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: Re: [PATCH 0/4] Integrate better device support
Message-ID: <20120206123418.GE17650@aemeltch-MOBL1>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Jan 27, 2012 at 04:47:22PM +0100, David Herrmann wrote:
> Hi
> 
> "struct device" provides a drvdata-field that we should use properly to save
> _driver-data_. This series makes the hci-core use pointer-arithmetic to avoid
> using this field in the bus-core and instead converts the drivers to use the
> drvdata field.
> This also reduces the hci_dev structure by 4/8 bytes, yeah.

I do not know does it related to those changes but recently I got several
dumps like shown below:

[  276.028121] Bluetooth: Virtual HCI driver ver 1.3
[  277.028692] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  277.054874] Bluetooth: BNEP filters: protocol multicast

< here comes module unloading>

[  302.632063] usbcore: deregistering interface driver btusb
[  302.664760] BUG: unable to handle kernel paging request at c16bef8f
[  302.668371] IP: [<c12a9011>] kobject_get+0x11/0x30
[  302.668371] *pde = 36785063 *pte = 016be161 
[  302.668371] Oops: 0003 [#1] SMP 
[  302.668371] Modules linked in: hci_vhci(O) btusb(-) bluetooth(O)
snd_intel8x0 joydev snd_ac97_codec ac97_bus snd_pcm ppdev snd_seq
snd_timer snd_seq_device parport_pc snd binfmt_misc psmouse serio_raw
soundcore snd_page_alloc i2c_piix4 lp parport usbhid hid ahci libahci
e1000 [last unloaded: bnep]
[  302.668371] 
[  302.668371] Pid: 4310, comm: rmmod Tainted: G           O 3.2.0niko+
#74 innotek GmbH VirtualBox
[  302.668371] EIP: 0060:[<c12a9011>] EFLAGS: 00010206 CPU: 0
[  302.668371] EIP is at kobject_get+0x11/0x30
[  302.668371] EAX: 6f6c2e71 EBX: c16bef73 ECX: 00000006 EDX: 00000000
[  302.668371] ESI: c16be46b EDI: f5655c00 EBP: e9415e5c ESP: e9415e58
[  302.668371]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  302.668371] Process rmmod (pid: 4310, ti=e9414000 task=e982bea0
task.ti=e9414000)
[  302.668371] Stack:
[  302.668371]  f45c6400 e9415e64 c1366a16 e9415e90 f81589d8 00000002
f67e1d88 f67a6000
[  302.668371]  e9415e90 c16bef6b 00000000 f5655c1c f5655c00 f815c1d8
e9415eac c13e7bef
[  302.668371]  00000000 f67a6000 f5655c1c f815c1d8 f5655c50 e9415ebc
c136aaaa f5655c1c
[  302.668371] Call Trace:
[  302.668371]  [<c1366a16>] get_device+0x16/0x20
[  302.668371]  [<f81589d8>] btusb_disconnect+0x48/0xe0 [btusb]
[  302.668371]  [<c13e7bef>] usb_unbind_interface+0x3f/0x150
[  302.668371]  [<c136aaaa>] __device_release_driver+0x6a/0xc0
[  302.668371]  [<c136b2e7>] driver_detach+0x97/0xa0
[  302.668371]  [<c136a944>] bus_remove_driver+0x74/0xe0
[  302.668371]  [<c136b988>] driver_unregister+0x48/0x80
[  302.668371]  [<c13e701c>] usb_deregister+0xac/0xc0
[  302.668371]  [<f815a0ed>] btusb_driver_exit+0xd/0xf20 [btusb]
[  302.668371]  [<c108f455>] sys_delete_module+0x135/0x250
[  302.668371]  [<c113f0bd>] ? vfs_write+0xed/0x160
[  302.668371]  [<c113e4a0>] ? wait_on_retry_sync_kiocb+0x50/0x50
[  302.668371]  [<c15668ad>] ? restore_all+0xf/0xf
[  302.668371]  [<c156d71f>] sysenter_do_call+0x12/0x38
[  302.668371] Code: 24 08 c7 04 24 28 7a 7e c1 e8 1c 5c 01 00 8b 4c 24 18
e9 d0 fe ff ff 8d 76 00 55 85 c0 89 e5 53 89 c3 74 0b 8b 40 1c 85 c0 74 09
<3e> ff 43 1c 89 d8 5b 5d c3 ba 28 00 00 00 b8 9d 7b 6b c1 e8 17 
[  302.668371] EIP: [<c12a9011>] kobject_get+0x11/0x30 SS:ESP
0068:e9415e58
[  302.668371] CR2: 00000000c16bef8f
[  302.668371] ---[ end trace de038ac80f57694f ]---

I have to say that usually I recompile only bluetooth modules and reload
them, IMO this should not trigger it.

Best regards 
Andrei Emeltchenko 

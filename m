Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120206123418.GE17650@aemeltch-MOBL1>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	<20120206123418.GE17650@aemeltch-MOBL1>
Date: Mon, 6 Feb 2012 15:03:20 +0100
Message-ID: <CANq1E4QA3W8A4p6=0JnvWtp0icz+KwsSiYH8hGi++tRWZUmLwg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Integrate better device support
From: David Herrmann <dh.herrmann@googlemail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org,
	johan.hedberg@gmail.com, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei

On Mon, Feb 6, 2012 at 1:34 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi David,
>
> On Fri, Jan 27, 2012 at 04:47:22PM +0100, David Herrmann wrote:
>> Hi
>>
>> "struct device" provides a drvdata-field that we should use properly to =
save
>> _driver-data_. This series makes the hci-core use pointer-arithmetic to =
avoid
>> using this field in the bus-core and instead converts the drivers to use=
 the
>> drvdata field.
>> This also reduces the hci_dev structure by 4/8 bytes, yeah.
>
> I do not know does it related to those changes but recently I got several
> dumps like shown below:

As far as I know Johan hasn't applied them yet so it is probably not
related to this patchset. I'd rather guess that it is related to my
previous changes. I will look at this later but I wasn't able to
trigger it, yet.

> [ =A0276.028121] Bluetooth: Virtual HCI driver ver 1.3
> [ =A0277.028692] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [ =A0277.054874] Bluetooth: BNEP filters: protocol multicast
>
> < here comes module unloading>
>
> [ =A0302.632063] usbcore: deregistering interface driver btusb
> [ =A0302.664760] BUG: unable to handle kernel paging request at c16bef8f
> [ =A0302.668371] IP: [<c12a9011>] kobject_get+0x11/0x30
> [ =A0302.668371] *pde =3D 36785063 *pte =3D 016be161
> [ =A0302.668371] Oops: 0003 [#1] SMP
> [ =A0302.668371] Modules linked in: hci_vhci(O) btusb(-) bluetooth(O)
> snd_intel8x0 joydev snd_ac97_codec ac97_bus snd_pcm ppdev snd_seq
> snd_timer snd_seq_device parport_pc snd binfmt_misc psmouse serio_raw
> soundcore snd_page_alloc i2c_piix4 lp parport usbhid hid ahci libahci
> e1000 [last unloaded: bnep]
> [ =A0302.668371]
> [ =A0302.668371] Pid: 4310, comm: rmmod Tainted: G =A0 =A0 =A0 =A0 =A0 O =
3.2.0niko+
> #74 innotek GmbH VirtualBox
> [ =A0302.668371] EIP: 0060:[<c12a9011>] EFLAGS: 00010206 CPU: 0
> [ =A0302.668371] EIP is at kobject_get+0x11/0x30
> [ =A0302.668371] EAX: 6f6c2e71 EBX: c16bef73 ECX: 00000006 EDX: 00000000
> [ =A0302.668371] ESI: c16be46b EDI: f5655c00 EBP: e9415e5c ESP: e9415e58
> [ =A0302.668371] =A0DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [ =A0302.668371] Process rmmod (pid: 4310, ti=3De9414000 task=3De982bea0
> task.ti=3De9414000)
> [ =A0302.668371] Stack:
> [ =A0302.668371] =A0f45c6400 e9415e64 c1366a16 e9415e90 f81589d8 00000002
> f67e1d88 f67a6000
> [ =A0302.668371] =A0e9415e90 c16bef6b 00000000 f5655c1c f5655c00 f815c1d8
> e9415eac c13e7bef
> [ =A0302.668371] =A000000000 f67a6000 f5655c1c f815c1d8 f5655c50 e9415ebc
> c136aaaa f5655c1c
> [ =A0302.668371] Call Trace:
> [ =A0302.668371] =A0[<c1366a16>] get_device+0x16/0x20
> [ =A0302.668371] =A0[<f81589d8>] btusb_disconnect+0x48/0xe0 [btusb]
> [ =A0302.668371] =A0[<c13e7bef>] usb_unbind_interface+0x3f/0x150
> [ =A0302.668371] =A0[<c136aaaa>] __device_release_driver+0x6a/0xc0
> [ =A0302.668371] =A0[<c136b2e7>] driver_detach+0x97/0xa0
> [ =A0302.668371] =A0[<c136a944>] bus_remove_driver+0x74/0xe0
> [ =A0302.668371] =A0[<c136b988>] driver_unregister+0x48/0x80
> [ =A0302.668371] =A0[<c13e701c>] usb_deregister+0xac/0xc0
> [ =A0302.668371] =A0[<f815a0ed>] btusb_driver_exit+0xd/0xf20 [btusb]
> [ =A0302.668371] =A0[<c108f455>] sys_delete_module+0x135/0x250
> [ =A0302.668371] =A0[<c113f0bd>] ? vfs_write+0xed/0x160
> [ =A0302.668371] =A0[<c113e4a0>] ? wait_on_retry_sync_kiocb+0x50/0x50
> [ =A0302.668371] =A0[<c15668ad>] ? restore_all+0xf/0xf
> [ =A0302.668371] =A0[<c156d71f>] sysenter_do_call+0x12/0x38
> [ =A0302.668371] Code: 24 08 c7 04 24 28 7a 7e c1 e8 1c 5c 01 00 8b 4c 24=
 18
> e9 d0 fe ff ff 8d 76 00 55 85 c0 89 e5 53 89 c3 74 0b 8b 40 1c 85 c0 74 0=
9
> <3e> ff 43 1c 89 d8 5b 5d c3 ba 28 00 00 00 b8 9d 7b 6b c1 e8 17
> [ =A0302.668371] EIP: [<c12a9011>] kobject_get+0x11/0x30 SS:ESP
> 0068:e9415e58
> [ =A0302.668371] CR2: 00000000c16bef8f
> [ =A0302.668371] ---[ end trace de038ac80f57694f ]---
>
> I have to say that usually I recompile only bluetooth modules and reload
> them, IMO this should not trigger it.
>
> Best regards
> Andrei Emeltchenko

Regards
David

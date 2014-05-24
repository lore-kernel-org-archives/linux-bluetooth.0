Return-Path: <cyrus@holtmann.org>
Date: Sat, 24 May 2014 09:34:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Magnus =?iso-8859-1?Q?Larsg=E5rden?= <larsgarden@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Kernel 3.14.4, BlueZ 5.18 - Bluetooth keyboard - error updating
 services: Input/output error (5)
Message-ID: <20140524063440.GA24167@t440s.P-661HNU-F1>
References: <CAPoRPAunSBGZPGPt9_T9kDsNM2M_JqoK3das76ST+Z-FfxLXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAPoRPAunSBGZPGPt9_T9kDsNM2M_JqoK3das76ST+Z-FfxLXUg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Magnus,

On Fri, May 23, 2014, Magnus Larsgården wrote:
> The setup:
> Raspberry Pi revB
> OpenELEC 4.0.2 (Linux kernel 3.14.4)
> 
> # /usr/lib/bluetooth/bluetoothd -v
> 5.18
> 
> # bluetoothctl -v
> 5.18
> 
> Bluetooth keyboard, Microsoft Wedge Keyboard
> 
> 
> The problem:
> The keyboard is detected, paired and connected, but after a couple of
> seconds it gets disconnected.
> 
> [bluetooth]# connect 7C:1E:52:18:7D:4F
> Attempting to connect to 7C:1E:52:18:7D:4F
> [CHG] Device 7C:1E:52:18:7D:4F Connected: yes
> .... ~20 seconds pass.....
> Failed to connect: org.bluez.Error.Failed
> [CHG] Device 7C:1E:52:18:7D:4F Connected: no
> 
> From bluetoothd:
> 
> bluetoothd[513]: src/adapter.c:discovering_callback() hci0 type 1 discovering 0
> bluetoothd[513]: src/adapter.c:trigger_start_discovery()
> bluetoothd[513]: 7C:1E:52:18:7D:4F: error updating services:
> Input/output error (5)
> bluetoothd[513]: src/device.c:device_svc_resolved()
> /org/bluez/hci0/dev_7C_1E_52_18_7D_4F err -5
> bluetoothd[513]: src/adapter.c:dev_disconnected() Device
> 7C:1E:52:18:7D:4F disconnected, reason 2
> bluetoothd[513]: src/adapter.c:adapter_remove_connection()
> bluetoothd[513]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> 7C:1E:52:18:7D:4F type 0 status 0xe
> bluetoothd[513]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x0e
> bluetoothd[513]: src/device.c:device_bonding_failed() status 14
> bluetoothd[513]: src/adapter.c:resume_discovery()
> 
> I would appreciate any help here.

It would help analyze the issue if you could provide HCI-level logs for
the disconnection. You can accomplish this by running btmon -w <filename>
while performing the use case.

Johan

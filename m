Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EA564C1.8070402@monom.org>
References: <4EA564C1.8070402@monom.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 24 Oct 2011 11:19:19 -0200
Message-ID: <CAMOw1v6Ec=GXvp3nZWa0=vALwWguXO3uo_DHqRJMXyV=_htO_w@mail.gmail.com>
Subject: Re: [BUG] Invalid file descriptor.
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Mon, Oct 24, 2011 at 11:14 AM, Daniel Wagner <wagi@monom.org> wrote:
> To whom it might concern,
>
> if bluez is running without an agent and the remote device tries to connect
> to bluez you are able to trigger the "Invalid file descriptor".
>
>
> bluetoothd[30869]: src/event.c:btd_event_bonding_complete() status 0x00
> bluetoothd[30869]: src/adapter.c:adapter_get_device() A0:4E:04:F6:F5:05
> bluetoothd[30869]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x00
> bluetoothd[30869]: audio/manager.c:hf_io_cb() Authorization denied!
>
> (bluetoothd:30869): GLib-WARNING **: Invalid file descriptor.
>
> bluetoothd[30869]: plugins/hciops.c:disconn_complete() handle 44 status 0x00
> bluetoothd[30869]: src/event.c:btd_event_disconn_complete()
> bluetoothd[30869]: src/adapter.c:adapter_remove_connection()
>
>
> cheers,
> daniel
>
> ps: I was told to report all crashes and bugs I find. Be prepared. I am a
> very capable finding bugs :)

What about the patch?


Lucas De Marchi

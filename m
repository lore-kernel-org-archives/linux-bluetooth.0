Return-Path: <cyrus@holtmann.org>
Message-ID: <4EA566BC.6070204@monom.org>
Date: Mon, 24 Oct 2011 15:23:08 +0200
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [BUG] Invalid file descriptor.
References: <4EA564C1.8070402@monom.org> <CAMOw1v6Ec=GXvp3nZWa0=vALwWguXO3uo_DHqRJMXyV=_htO_w@mail.gmail.com>
In-Reply-To: <CAMOw1v6Ec=GXvp3nZWa0=vALwWguXO3uo_DHqRJMXyV=_htO_w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On 10/24/2011 03:19 PM, Lucas De Marchi wrote:
> On Mon, Oct 24, 2011 at 11:14 AM, Daniel Wagner<wagi@monom.org>  wrote:
>> To whom it might concern,
>>
>> if bluez is running without an agent and the remote device tries to connect
>> to bluez you are able to trigger the "Invalid file descriptor".
>>
>>
>> bluetoothd[30869]: src/event.c:btd_event_bonding_complete() status 0x00
>> bluetoothd[30869]: src/adapter.c:adapter_get_device() A0:4E:04:F6:F5:05
>> bluetoothd[30869]: src/device.c:device_bonding_complete() bonding (nil)
>> status 0x00
>> bluetoothd[30869]: audio/manager.c:hf_io_cb() Authorization denied!
>>
>> (bluetoothd:30869): GLib-WARNING **: Invalid file descriptor.
>>
>> bluetoothd[30869]: plugins/hciops.c:disconn_complete() handle 44 status 0x00
>> bluetoothd[30869]: src/event.c:btd_event_disconn_complete()
>> bluetoothd[30869]: src/adapter.c:adapter_remove_connection()
>>
>>
>> cheers,
>> daniel
>>
>> ps: I was told to report all crashes and bugs I find. Be prepared. I am a
>> very capable finding bugs :)
>
> What about the patch?

Sure, I will do as soon I have fixed all outstanding ConnMan bugs I 
found just recently. In other words don't expect very soon this patch :)

cheers,
daniel

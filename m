Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABuKQijYU5Ndst=ZKjPcy0MEOrmocAgNE_BDppgYNf_L0iBmBw@mail.gmail.com>
References: <CABuKQijYU5Ndst=ZKjPcy0MEOrmocAgNE_BDppgYNf_L0iBmBw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Nov 2016 13:32:32 +0200
Message-ID: <CABBYNZ+3dSkOwV2a+TqOTRvwfiYBhq9ODfDR+fZ0iKgcTpesGQ@mail.gmail.com>
Subject: Re: Why bluetoothd disconnect immediate follow connected event ,
 what's wrong with my bluez ?
To: Trump DD <wrxzzj@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Nov 13, 2016 at 11:48 AM, Trump DD <wrxzzj@gmail.com> wrote:
> Hi guys
>    I met a very strang issue about config Microsoft Designer Mouse
> (Bluetooth LE)
> I have paired and trust my devices already, and connected it success,
> all works fine.
> But after I reboot my computer,  when I click a mouse button, I see
> 'connected'  in bluetoothctl, immediate a 'disconnect' event follow.
> what's wrong with my bluetooth.
> below it's my log files
>
> bluetoothctl log:
> [NEW] Controller A4:34:D9:2B:2E:41 debian [default]
> [NEW] Device C0:11:5B:C2:55:DF Designer Mouse
> [CHG] Device C0:11:5B:C2:55:DF Connected: yes
> [CHG] Device C0:11:5B:C2:55:DF Connected: no
> [bluetooth]# info C0:11:5B:C2:55:DF
> Device C0:11:5B:C2:55:DF
>         Name: Designer Mouse
>         Alias: Designer Mouse
>         Appearance: 0x03c2
>         Icon: input-mouse
>         Paired: yes
>         Trusted: yes
>         Blocked: no
>         Connected: no
>         LegacyPairing: no
>         UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>         UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>         UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>         UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v045Ep0805d0110
> [bluetooth]#
>
>
> bluetoothd log after I click mouse button:
>
> bluetoothd[552]: src/adapter.c:connected_callback() hci0 device
> C0:11:5B:C2:55:DF connected eir_len 27
> bluetoothd[552]: src/adapter.c:disconnected_callback() reason = 2
> bluetoothd[552]: src/adapter.c:dev_disconnected() Device
> C0:11:5B:C2:55:DF disconnected, reason 2
> bluetoothd[552]: src/adapter.c:adapter_remove_connection()
> bluetoothd[552]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> C0:11:5B:C2:55:DF type 2 status 0xe
> bluetoothd[552]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x0e
> bluetoothd[552]: src/device.c:device_bonding_failed() status 14
> bluetoothd[552]: src/adapter.c:resume_discovery()

Looks like there is a regression with latest git, please check with
the patch Ive just sent:

[PATCH BlueZ] core/adapter: Fix using wrong address type to listen ATT


-- 
Luiz Augusto von Dentz

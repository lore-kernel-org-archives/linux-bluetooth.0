Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <43a125d60469ce919959790a88bce71707b05306.camel@hadess.net>
References: <20180725102035.19439-1-luiz.dentz@gmail.com> <20180725102035.19439-3-luiz.dentz@gmail.com>
 <43a125d60469ce919959790a88bce71707b05306.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Jul 2018 17:19:14 +0300
Message-ID: <CABBYNZ+14JwEN1=pTVaLYOzRa-PzUH=feD_X9LepFnyhTgs4xg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] adapter: Track pending settings
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 26, 2018 at 3:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2018-07-25 at 13:20 +0300, Luiz Augusto von Dentz wrote:
>> -                               property_set_mode_complete, data, g_free) > 0)
>> +                       property_set_mode_complete, data, g_free) > 0)
>
> White space change is probably not needed here.
>
> This patch and 4/4 don't work as expected though. I use this set of 2
> commands to replicate what gnome-bluetooth did:
>
> dbus-send  --system --dest=org.bluez /org/bluez/hci0
> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
> string:Discoverable variant:boolean:false ; dbus-send  --system --
> dest=org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties.Set
> string:org.bluez.Adapter1 string:DiscoverableTimeout variant:uint32:0
>
> You can add a "print-reply" which will wait for the caller to return.
> In my case, without the --print-reply, property_set_mode will never be
> called.

It looks like dbus-send cannot be used since it exits immediately,
anyway I tried by modifying bluetoothctl and it seems to be working
properly:

https://gist.github.com/Vudentz/69737e4cc236f24d33404fffc5e51ff4


-- 
Luiz Augusto von Dentz

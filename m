Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b556d8b-b0ee-543f-2ca1-0ef9a48172ee@gmail.com>
References: <6b556d8b-b0ee-543f-2ca1-0ef9a48172ee@gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Wed, 20 Jul 2016 15:39:10 +0100
Message-ID: <CAAu3APbbPGtitaEb5YSDxqyuQWdrERUiRGo5YLdYV-OVJLC9RQ@mail.gmail.com>
Subject: Re: AVRCP: player object path
To: Marco Trapanese <marcotrapanese@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marco,

On 20 July 2016 at 13:26, Marco Trapanese <marcotrapanese@gmail.com> wrote:
> Hello, I'm trying to implement some function of AVRCP protocol. From here:
>
> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/media-api.txt
>
> I don't understand how to retreive the |object path| of my player:
>
>    Object path [variable
>    prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
>
> I'm not sure if it is returned from some DBus methods or I have to manually
> build it using the bluetooth address and the local device.

This is something I'm currently trying to get my head around.

There appears to be a dbus.INTROSPECTABLE_IFACE interface that has an
Introspect() method.

I've got an example of using it in Python at:
https://github.com/ukBaz/python-bluezero/blob/master/examples/iterate.py
In build_introspection()

You can do something similar on the command line with:
gdbus introspect --system --dest org.bluez --object-path / --recurse

Hope that helps move you forward.

Regards,
Barry

>
> Thanks!
> Marco
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

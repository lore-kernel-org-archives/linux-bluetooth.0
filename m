Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACw_oNeRd1nv0TFFdCrxEPtvcfhOdDiFY7TtYY2EGz9dUU2SkA@mail.gmail.com>
References: <CACw_oNeRd1nv0TFFdCrxEPtvcfhOdDiFY7TtYY2EGz9dUU2SkA@mail.gmail.com>
Date: Mon, 26 Jan 2015 18:06:29 +0800
Message-ID: <CACw_oNcLV-TBAnhJ66PQDZuXi751exwnt=mfwBBvAVP7Y8dmzA@mail.gmail.com>
Subject: Re: question about no responds to my bluetooth keyboard
From: M Ren <itux.ren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

does it need some special config in bluez ,
I compile bluez like this :
      --prefix=/usr \
      --libdir=/usr/lib \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --build=$(ARCH_BUILD) \
      --host=$(TARGET_ARCH) \
      --enable-debug \
      --disable-obex \
      --enable-client \
      --disable-systemd \
      --disable-datafiles \
      --enable-experimental \
      --enable-sixaxis \
      --with-udevdir=/etc/udev \
      --with-dbusconfdir=/dummy/ \
      --with-dbussystembusdir=/dummy/ \
      --with-dbussessionbusdir=/dummy/

2015-01-26 10:09 GMT+08:00 M Ren <itux.ren@gmail.com>:
> [bluetooth]# connect 01:02:03:04:05:06
>
> Hi,
>
> The issue I met is simple:
> I use bluetoothctl connect to a bluetooth keyboard on my dev board,
> follow this instruction https://wiki.archlinux.org/index.php/Bluetooth_keyboard
> [bluetooth]# power on
> [bluetooth]# agent KeyboardOnly
> [bluetooth]# pairable on
> [bluetooth]# pair 01:02:03:04:05:06
> [bluetooth]# trust 01:02:03:04:05:06
> [bluetooth]# connect 01:02:03:04:05:06
> [bluetooth]# quit
> output shows "Connection successful"
>
> But dev board didn't respond to any keypress.
> What maybe the reason ?
> appreciate any advices, if some log is needed, please tell me.
>
> BTW, keyboard on pc works ok.
>
> Thanks.

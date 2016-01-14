Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1452726452.1830.3.camel@redhat.com>
References: <1452726452.1830.3.camel@redhat.com>
Date: Thu, 14 Jan 2016 13:02:32 -0300
Message-ID: <CABBYNZK024x77WYqiCrjX7GXXPU46zjNFhhhmrVd-y-XK4gWmw@mail.gmail.com>
Subject: Re: bluetoothd crash when registering advertisement
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nathaniel McCallum <npmccallum@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathaniel,

On Wed, Jan 13, 2016 at 8:07 PM, Nathaniel McCallum
<npmccallum@redhat.com> wrote:
> I added advertisement support to my application today:
> https://git.fedorahosted.org/cgit/jelling/linux.git/commit/?id=e04016c8
> b7f0d406b39573863cf7d5e15dac53ed
>
> When registering the advertisement with bluez, bluetoothd crashes:
> #0  0x00007f1f01ce6618 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007f1f01ce821a in __GI_abort () at abort.c:89
> #2  0x00007f1f024bc894 in _dbus_abort () at ../../dbus/dbus-
> sysdeps.c:91
> #3  0x00007f1f024b331e in _dbus_warn_check_failed (
>     format=0x7f1f024c2d10 "arguments to %s() were incorrect, assertion
> \"%s\" failed in file %s line %d.\nThis is normally a bug in some
> application using the D-Bus library.\n") at ../../dbus/dbus-
> internals.c:275

Is your application still connected to D-Bus when that happens?

> As this was my first attempt at implementing advertisement support, I
> may be doing something wrong. If I am, your tips are appreciated!
> However, in any case, bluez shouldn't crash.

We will definitely have to fix the crash but it would help if you
share more information, like how your application is implemented and
have access to bluetoothd logs before it crashes.


-- 
Luiz Augusto von Dentz

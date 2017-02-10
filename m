Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHHBb0cUctkkkisSdhosNms9QWmbRVwJm2BTwuEb64+V1eepag@mail.gmail.com>
References: <CAHHBb0cUctkkkisSdhosNms9QWmbRVwJm2BTwuEb64+V1eepag@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Feb 2017 12:32:05 +0200
Message-ID: <CABBYNZJy2LaSwR46cgStuZ6bJsAURXf3CLcrRxK-HtQWmDZ0qg@mail.gmail.com>
Subject: Re: Don't understand BlueZ 5 GATT interface
To: Dave Beal <dbeal@cardinalpeak.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

On Thu, Feb 9, 2017 at 9:10 PM, Dave Beal <dbeal@cardinalpeak.com> wrote:
> Hello -
>
> I'm trying to write a GATT client using BlueZ 5.19. Neither Python nor
> glib are available in my environment, so I'm reduced to using libdbus.
> I understand that I call Bluez's RegisterProfile method to specify the
> UUID of the profile/service that I want to connect to, and that when a
> matching remote device is found, Bluez will call my NewConnection
> method. (This currently isn't working for me, but that's a different
> question, posed in an earlier email.) The NewConnection call passes a
> file descriptor that I use to talk to the remote device. Then what?
> What do I send over the connection in order to, for instance, read and
> write an attribute? Link layer messages? ATT protocol commands?
> Thanks!

5.19 is very old, can't you upgrade? Btw, while it is true that
RegisterProfile is used to program the auto-connect logic, it only
takes place once the device has been connected/paired already. Devices
that have been just discovered are considered temporary thus why
auto-connect logic don't work for them.

-- 
Luiz Augusto von Dentz

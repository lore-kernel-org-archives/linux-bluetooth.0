Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMib2Ga66EkT7QWSZi_ew+ESQ_O97koY3OZgCy8mOiUnXes0wg@mail.gmail.com>
References: <CAMib2Ga66EkT7QWSZi_ew+ESQ_O97koY3OZgCy8mOiUnXes0wg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Aug 2016 16:47:40 +0300
Message-ID: <CABBYNZLRfpAgMXFrq01WaOYvbL=o2nsCdBejEn23igq-W794Gw@mail.gmail.com>
Subject: Re: MediaFolder interface
To: Kyle Shneider <shneiderkyle@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

On Tue, Aug 16, 2016 at 11:09 PM, Kyle Shneider <shneiderkyle@gmail.com> wrote:
> Hello.
> I'm successfully setting connection between iOS a2dp source and linux
> a2dp sink and...
> 1) When I'm trying to use Search method of MediaFolder1 interface
> passing different arguments it always returns NotSupported error

There were a bug detecting the support for, I just posted a patch-set
with a fix for that but iOS needs to support searching which I recall
was not supported but maybe this has been added there.

> (ListItems and ChangeFolder methods works fine). In the bluez docs it
> is written that property 'Searchable' of player object (it is False on
> default) can be enabled using MediaFolder interface. So how can I
> change this property to True?

You can't change that since it indicates a remote device capability.

> 2) What is the acceptable format of 'dict filter' argument of
> ListItems method (and Search)? I've tried different variants but it's
> always InvalidArguments error.
> - {'Start':0, 'End':0, 'Attributes':['track', 'album']}
> - dbus.Dictionary({'Start':0, 'End':0, 'Attributes':['track',
> 'album']}, signature:'sv')
> - etc
> When I pass an empty dictionary to this method everything ok.

There are no filters defined for search, it was probably introduced as
a place holder in case the AVRCP allows more than a string search
someday.


-- 
Luiz Augusto von Dentz

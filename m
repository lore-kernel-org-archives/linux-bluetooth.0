Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1267100354.22889.16.camel@flashheart.burtonini.com>
References: <1267100354.22889.16.camel@flashheart.burtonini.com>
Date: Fri, 26 Feb 2010 11:24:11 +0200
Message-ID: <2d5a2c101002260124w2a526e5bh4622af9658e179c0@mail.gmail.com>
Subject: Re: DiscoverableTimeout not working as expected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ross Burton <ross@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ross,

On Thu, Feb 25, 2010 at 2:19 PM, Ross Burton <ross@linux.intel.com> wrote:
> Hi,
>
> My client calls SetProperty(DiscoverTimeout, 20) then
> SetProperty(Discoverable, True) on my adaptor, but I don't get the
> expected behaviour:
>
> signal sender=:1.2 -> dest=(null destination) serial=847 path=/org/bluez/1564/hci0; interface=org.bluez.Adapter; member=PropertyChanged
>   string "DiscoverableTimeout"
>   variant       uint32 20
> signal sender=:1.2 -> dest=(null destination) serial=850 path=/org/bluez/1564/hci0; interface=org.bluez.Adapter; member=PropertyChanged
>   string "Discoverable"
>   variant       boolean true
> signal sender=:1.2 -> dest=(null destination) serial=852 path=/org/bluez/1564/hci0; interface=org.bluez.Adapter; member=PropertyChanged
>   string "DiscoverableTimeout"
>   variant       uint32 0

I got a different behavior (using git tree and testtest-adapter):

signal sender=:1.65 -> dest=(null destination) serial=151
path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "DiscoverableTimeout"
   variant       uint32 10
signal sender=:1.65 -> dest=(null destination) serial=160
path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Discoverable"
   variant       boolean true
signal sender=:1.65 -> dest=(null destination) serial=161
path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Class"
   variant       uint32 6430988
signal sender=:1.65 -> dest=(null destination) serial=162
path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Discoverable"
   variant       boolean false
signal sender=:1.65 -> dest=(null destination) serial=163
path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Class"
   variant       uint32 6422796

> As the timeout is now 0, discoverable never resets itself to false.

Basically the timeout is persistent so once set it will be triggered
every time you switch the adapter to discoverable, in other words it
wont change to 0 automatically anymore, I guess this was an old
behavior but it has been changed long time ago.

> Am I doing something stupid, or is setting the discovery timeout broken?

I guess what you need is to update your bluez version then it should work.


-- 
Luiz Augusto von Dentz
Computer Engineer

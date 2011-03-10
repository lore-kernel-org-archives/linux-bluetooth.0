Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 12:37:54 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: loody <miloody@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: some questions about Bluez
Message-ID: <20110310153754.GA2190@joana>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loody,

* loody <miloody@gmail.com> [2011-03-10 20:33:49 +0800]:

> hi all:
> I have some questions about bluetooth.
> 1. how many additional libs that I need to successfully compile bluez?
> so far as I know are:
>     a. DBUS
>     b. GLIB
>     c. ALSA
>     d. GSTREAMER
>     e. USB
>     f. SNDFILE
>     g.CAPNG
> am I right?
> 
> 2. I try to compile Bluez to run on mips platform.
> What I need is a simple tool which can tell me what kind of bluetooth
> device around my usb bluetooth controller.
> it seems I only need to enable USB lib above, right?
> 
> 3. from configure, I found we can turn off features by setting
> "--disable-xxxx", so I use below configure command for configuring
> ./configure --prefix=/media/sdb1/bluez-4.89.mips/build
> --host=mipsel-linux-gnu --disable-optimization --disable-fortify
> --disable-pie --disable-network --disable-serial --disable-input
> --disable-audio --disable-service
> 
> but it still complain to me that he cannot find alsa header files and libs.

The ./configure line you provided work for me in x86_64. Can you provide the
logs of ./configure && make?

-- 
Gustavo F. Padovan
http://profusion.mobi

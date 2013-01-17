Return-Path: <cyrus@holtmann.org>
Message-ID: <1358400337.3059.11.camel@aeonflux>
Subject: Re: bluez: atomic operations
From: Marcel Holtmann <marcel@holtmann.org>
To: "Kling, Andreas" <Andreas.Kling@peiker.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Jan 2013 21:25:37 -0800
In-Reply-To: <sig.6728472516.B3F251FD87EC894A88C2221EEEBDF54807096F7F3B@Exchange>
References: <sig.6728472516.B3F251FD87EC894A88C2221EEEBDF54807096F7F3B@Exchange>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> using gcc atomic buildins breaks support for older gcc/platforms.
> 
> src/bluetoothd-adapter.o: In function `btd_adapter_unref':
> adapter.c:(.text+0x63f8): undefined reference to `__sync_sub_and_fetch_4'
> 
> I suggest to use glib g_atomic_* group of functions.
> They fall back to traditional locking if buildins are not available.

the GLib atomic API functions are not really stable. The GLib people for
some reason decided to break their own API/ABI guarantee. So we moved
away from using them. And I have no intention to get back to them.

Long term, we are moving away from GLib and want to switch to ELL. So
that means gcc atomics are required. My advise would be to get a modern
platform and not rely on workarounds.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Message-ID: <1332200404.3362.0.camel@maxim-laptop>
Subject: Re: bluez doesn't handle hotplug well
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Mar 2012 01:40:04 +0200
In-Reply-To: <1332044343.2998.8.camel@maxim-laptop>
References: <1332044343.2998.8.camel@maxim-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-03-18 at 06:19 +0200, Maxim Levitsky wrote: 
> Recently I began using Bluetooth, and I noticed that it sometimes
> doesn't work after suspend to ram.
> 
> It turns out to be 100% reproduciable and not related to ether bluetooth
> dongle (tested 2 of them) nor related to KDE/Gnome - happens in both,
> and nether its related to actual suspend.
> 
> To reproduce, I just start bluetoothd, then:
> 1. I plug the dongle, its recognized (or start bluetoothd after I plug
> it, doesn't matter)
> 
> 2. I unplug it.
> 3. I plug it again, and it is recognized again
> 4. I unplug it.
> 5. I plug it, and it doesn't work.
> 
> Reproducible, always, tested many times.
> restarting bluetoothd fixes the problem until, I repeat the above.
> 
> bluetoothd log attached.
> I am (still) using ubuntu 12.04.
> 
> Best regards,
> Maxim Levitsky
Any update?

Best regards,
Maxim Levitsky


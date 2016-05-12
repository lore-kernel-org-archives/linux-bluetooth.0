Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 12 May 2016 11:56:25 +0200
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: gatt server and reset of hci device
Message-ID: <20160512095625.GA15660@arthur-bzh>
References: <20160511125102.GC17904@arthur-bzh>
 <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le Thursday 12 May 2016 à 11:39:44 (+0300), Luiz Augusto von Dentz a écrit :

> Is that something preventing you to use bluetoothd and just create a
> plugin or use the GATT API for your server? Manually using hciconfig
> is not recommended since it may interfere with other users, for manual
> testing it is actually recommended to use btmgmt or bluetoothd +
> bluetoothctl.

I need to have the ble server in my stand alone binary. That's why I am not using
bluetoothd plugin. About GATT API, you are probably talking about dbus api to
create custom service instead of using private c API. I am not very familiar
with dbus, I was not able to find a working example of dbus example with bluez5.
I have some delay issue to release my code, that's why I am using c api to gain
some precious time.

> Also note that having btgatt-server along side with
> bluetoothctl. Also note that having btgatt-server along side with
> bluetoothd will not work because both listen on the same channel and
> the kernel can only redirect the packets to one process.

I know that bluetoothd cannot run with my custom gatt server. Problem is that
I am not able to set hci friendly name with hciconfig without bluetoothd. So
I have a very dirty way to do it : run bluetoothd few seconds, kill it and then
run my code. Thanks to that I am able to update the hci friendly name (I guess
that some init which are missing in my code are running in bluetoothd)

So your advise is to use btmgmt instead of hciconfig to play with hci device ?

Thanks,
Arthur.

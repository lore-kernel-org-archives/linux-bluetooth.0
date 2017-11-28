Return-Path: <hadess@hadess.net>
Message-ID: <1511862359.11411.39.camel@hadess.net>
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Nov 2017 10:45:59 +0100
In-Reply-To: <1506085983.9350.33.camel@hadess.net>
References: <20170920125445.24792-1-hadess@hadess.net>
	 <20170920125445.24792-2-hadess@hadess.net>
	 <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
	 <1505925333.9350.7.camel@hadess.net>
	 <6DC51AD5-E9D5-4874-AAA8-38A4BF7C1668@holtmann.org>
	 <CABBYNZLeNiw_5A_mBbLm6Uq2B-8+KEhuMKAsVerSAKeS3WbE+g@mail.gmail.com>
	 <1506085983.9350.33.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

On Fri, 2017-09-22 at 15:13 +0200, Bastien Nocera wrote:
> 
<snip>
> It goes without saying that I wouldn't be sending bug reports like this
> one if I was using dbus-broker.
> 
> The plugin seems to work correctly in
> df0ad3ecb625b5968522acce8b7d33d68f30b4cb (plus build fixes), and
> systemd-hostnamed is autostarted.
> 
> I tried bisecting, but ended up screwing up at some point, and didn't
> fancy restarting again (after about 15 iterations, and having to
> cherry-pick different build fixes every time, sigh), so I started
> testing individual releases.
> 
> (4 other working versions)
> 5.46 works
> 5.47 fails
> 
> And after that:
> ef024c2c44b4f0dab3c054d062a911cacef1fdc9 is the first bad commit
> commit ef024c2c44b4f0dab3c054d062a911cacef1fdc9
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Fri Aug 11 15:39:15 2017 +0300
> 
>     gdbus: Fix calling GetAll while GetManagedObjects is pending
>     
>     If proxies are created while the client is not ready put them into a
>     pending list so only if they are not found in GetManagedObject reply
>     call GetAll.
> 
> :040000 040000 01462de94f24f0f561aab0be34bcfc0935718da7 6917c7faea1135c53fc1d8d9d43d6347952e5d40 M	gdbus

As discussed on IRC, this is still broken and should really be fixed
before the release. In the worst case, my work-around earlier in the
thread could also be applied if we're strapped for time.

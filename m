Return-Path: <cyrus@holtmann.org>
Subject: Re: Problems & crash with Bluecore6 and SDIO driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Matt Witherspoon <spoon@vt.edu>
Cc: linux-bluetooth@vger.kernel.org,
	David Vrabel <david.vrabel@csr.com>
In-Reply-To: <1225132303.4906090f12442@webmail.vt.edu>
References: <1225132303.4906090f12442@webmail.vt.edu>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 20:40:52 +0100
Message-Id: <1225136452.7157.20.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

> > Deep sleep control is done on a per-function basis so you need to write
> > 0x11 to disable deep sleep on function 1 (the bluetooth function).
> 
> Thanks for the response, David.
> 
> Applying Tomas' patch does indeed fix the crash.
> I put a sdio_f0_writeb(data->func, 0x11, 0xf0, NULL); in btsdio_open(). This
> register write does seem to have some effect. Without it, idle current was
> 0.6mA. With the write, idle current is around 2.5mA. However, the BC6 still
> will not respond to commands after being idle for several seconds. Or, it will
> respond but with bogus data (like a features bitfield of all 0x00s).
> 
> Then, I realized that if I run this command:
> hciconfig hci0 up ; bccmd psset -s psram -r 0x0229 0
> along with the register write, everything works great. I appear to have to do
> both: the register write and the PSKEY setting. One or the other alone is not
> sufficient.

the 0x0229 translates to PSKEY_DEEP_SLEEP_STATE if anybody wonders. So
for a full support of the BlueCore6 SDIO interface we would have to do a
little bit more work. I stopped looking into it since the only BlueCore6
that I have is an engineering release and I haven't checked it for a
while. Never got updated hardware. Hint hint ;)

> Does this seem correct to you? I can't see how btsdio could work on a BC6
> without following this process, unless I have a old bad firmware or something.

At the last BlueZ developer meeting, we discussed an init stage for all
Bluetooth drivers. The init stage then can be used to init hardware with
hardware specific details like PS settings or firmware download.

Regards

Marcel



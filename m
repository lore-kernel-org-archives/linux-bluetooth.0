Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sujay Sarkhel <ssarkhe@ncsu.edu>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Thermometer D-Bus API Signature
Date: Wed, 19 Nov 2014 19:55:32 +0100
Message-ID: <1721045.kgzKbrT3eS@leonov>
In-Reply-To: <CAE7yNv9vBFaBincdFbf=jRGMd1iD-biA4FRhwi5k4b2i2Wdt6Q@mail.gmail.com>
References: <CAE7yNv9vBFaBincdFbf=jRGMd1iD-biA4FRhwi5k4b2i2Wdt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujay,

On Friday 14 of November 2014 20:13:13 Sujay Sarkhel wrote:
> I was looking at the Health Thermometer Watcher hierarchy under
> docs/thermometer-api.txt and I guess the signature for the following
> method is incorrect:
> 
>            void MeasurementReceived(dict measurement)
> 
> In my opinion, it should be:
> 
>        void MeasurementReceived(object device, dict measurement)
> 
> i.e. same as the one defined under heartrate-api.txt
> 
> Unfortunately, I do not have an actual thermometer or an emulator to
> verify this but looking at the source code:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/profiles/thermometer/th
> ermometer.c for the method update_watcher (line #277), it looks that way.
> 
> Can some developer kindly verify this please? Thanks!

Yes, this looks like documentation issue. Care to send a patch?:)

-- 
BR
Szymon Janc

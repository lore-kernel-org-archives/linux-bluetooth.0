Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 6/9] android/bluetooth: Add support for remote device RSSI
Date: Thu, 12 Dec 2013 09:58:40 +0100
Message-ID: <3353914.oihVPgriBc@uw000953>
In-Reply-To: <CAJdJm_N2aABBteKtWyRXh_-a8Oy722BMbZSrH_koNYbY8F5hpA@mail.gmail.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com> <1386757887-29018-6-git-send-email-szymon.janc@tieto.com> <CAJdJm_N2aABBteKtWyRXh_-a8Oy722BMbZSrH_koNYbY8F5hpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Hi Szymon,
> 
> On Wed, Dec 11, 2013 at 7:31 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> \> @@ -2306,11 +2309,13 @@ static uint8_t
> get_device_friendly_name(struct device *dev)
> >
> >  static uint8_t get_device_rssi(struct device *dev)
> >  {
> > -       DBG("Not implemented");
> > +       if (!dev->rssi)
> > +               return HAL_STATUS_FAILED;
> 
> 0 dBm is a valid RSSI value, so I suppose this code needs some other
> way to identify an uninitialized value (e.g. a second boolean field.)

Kernel sends rssi==0 if rssi info was not present on inquiry so I used this
value, but maybe it should use 127 for that.. ? (yet, this might cause trouble
as linux bluetoothd is checking 0 as well)

-- 
BR
Szymon Janc



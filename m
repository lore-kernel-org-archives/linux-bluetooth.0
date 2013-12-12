Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3353914.oihVPgriBc@uw000953>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
	<1386757887-29018-6-git-send-email-szymon.janc@tieto.com>
	<CAJdJm_N2aABBteKtWyRXh_-a8Oy722BMbZSrH_koNYbY8F5hpA@mail.gmail.com>
	<3353914.oihVPgriBc@uw000953>
Date: Thu, 12 Dec 2013 09:03:29 -0200
Message-ID: <CAJdJm_P9Y2XU=X98c-hBTDz40HPXLtu3Q-8U9uQdQT2KXXrLXw@mail.gmail.com>
Subject: Re: [PATCH 6/9] android/bluetooth: Add support for remote device RSSI
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 12, 2013 at 5:58 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> On Wed, Dec 11, 2013 at 7:31 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> \> @@ -2306,11 +2309,13 @@ static uint8_t
>> get_device_friendly_name(struct device *dev)
>> >
>> >  static uint8_t get_device_rssi(struct device *dev)
>> >  {
>> > -       DBG("Not implemented");
>> > +       if (!dev->rssi)
>> > +               return HAL_STATUS_FAILED;
>>
>> 0 dBm is a valid RSSI value, so I suppose this code needs some other
>> way to identify an uninitialized value (e.g. a second boolean field.)
>
> Kernel sends rssi==0 if rssi info was not present on inquiry so I used this
> value, but maybe it should use 127 for that.. ? (yet, this might cause trouble
> as linux bluetoothd is checking 0 as well)

I remember commenting on this when mgmt API (it was for TX Power,
which is more common to be 0 dBm, but I can't remember what was the
result of the discussion). In any case, I think handling this way will
make devices that use TX Power higher than 0 dBm (and thus can make a
0dBm RSSI possible) not report their RSSI. It is not common IMHO, but
it is possible.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

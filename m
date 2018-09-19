Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180919140354.GA2739@amd>
References: <20180919140354.GA2739@amd>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Sep 2018 17:41:49 +0300
Message-ID: <CABBYNZKAHk_bi+LaKi55EVeW5LfLFKMqpXLGsfrsVVLQM9geew@mail.gmail.com>
Subject: Re: setting random address on a bluetooth low-energy adapter
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Wed, Sep 19, 2018 at 5:03 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I'm trying to use PC (with usb dongle) as a bluetooth low-energy
> device -- similar to heart rate sensor. But the device I'm trying to
> emulate is using random address and its control software seems to
> expect it.
>
> Is there way to override the address / set the random address?
> https://elinux.org/images/3/32/Doing_Bluetooth_Low_Energy_on_Linux.pdf
> says patch might be needed...
>
> Pointer to the patch would be welcome.

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=206bee144e2b7e3190677ffbf4f231dd2e728f5c



-- 
Luiz Augusto von Dentz

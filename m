Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: =?utf-8?B?SsOhbiBMYWxpxaE=?= <lalis.jan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: External Bluez plugin and GATT profile
Date: Mon, 16 Jun 2014 12:12:43 +0200
Message-ID: <6559042.7JUBoKaiZC@uw000953>
In-Reply-To: <CAOb4fKcq6R4PTo_m0j+e09hgkKj2nSizWd8_8j340pV-CrXAJg@mail.gmail.com>
References: <CAOb4fKcq6R4PTo_m0j+e09hgkKj2nSizWd8_8j340pV-CrXAJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ján,

On Tuesday 13 of May 2014 16:00:42 Ján Lališ wrote:
> Hi,
> 
> I want to create external plugin for Bluez where I create custom GATT
> profile. I created plugin without problems, but problem is with
> creating custom profile using function gatt_service_add (I dont find
> any other working solution in code for creating custom profile),
> because this function is not exported as external function.
> 
> I know that there are some exported functions (with btd_ prefix) but
> there is no example or documentation for how to use them and playing
> with this functions give me no working result. Very simple example
> will be good starting point for everyone, who want to start write
> custom profile for BLE usign Bluez API.

For now, I suggest making your code as a built-in plugin.

-- 
Best regards, 
Szymon Janc

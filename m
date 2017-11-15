Return-Path: <massot.julien@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9DD19A09-6011-49DC-9B03-05D783C3DC61@holtmann.org>
References: <CAHuuS6G0JCOHUiohpzzskg7x6kib-Y-ToibjX6vf4vTbwYkLcQ@mail.gmail.com>
 <9DD19A09-6011-49DC-9B03-05D783C3DC61@holtmann.org>
From: Julien Massot <massot.julien@gmail.com>
Date: Wed, 15 Nov 2017 09:06:50 +0100
Message-ID: <CAHuuS6FJUF0mO1DRe9mzC2h7Nx_LXL26wHSFzgVgeH8ZcN4jzQ@mail.gmail.com>
Subject: Re: AR3011 Device Under Test
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> Does anyone already succeed to put an AR3011 (managed by ATH3K driver),
>> under radio test condition ?
>
> you can use the HCI commands for test mode.

Thanks a lot, I didn't search the right way, and the solution was in bluetooth
specification.

Was stuck on WiFi way of thinking in which any constructor have it's own way.

So for future people looking at this topic please read
BLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
"7.6.3 Enable Device Under Test Mode Command"

Best Regards,
Julien

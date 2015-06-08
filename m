Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMPA5gdJPQPidhNo0gja5ohH_9Y1XXaG-ydT8bBripTaJCnL0g@mail.gmail.com>
References: <CAMPA5gdJPQPidhNo0gja5ohH_9Y1XXaG-ydT8bBripTaJCnL0g@mail.gmail.com>
Date: Mon, 8 Jun 2015 13:03:47 +0300
Message-ID: <CABBYNZLRe_WW6844OXKATwCk9NMzVxUkRquyYwjJbDGeSOqTFg@mail.gmail.com>
Subject: Re: Are there any simple GATT examples?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joshua Kramer <joskra42.list@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

On Sun, Jun 7, 2015 at 4:22 AM, Joshua Kramer <joskra42.list@gmail.com> wrote:
> Hello-
>
> Is there an example of a GATT server that implements a simple
> socket-type connection?  I am creating a device based on Raspberry Pi
> that needs to be controlled via an Android app.  I am using bluez on
> the Pi side.

Well a GATT service/attribute alone cannot do socket-type connection,
what you can do is to use write and read/notifications to emulate it
but the proper way would be to use connection oriented channels if
Android support it (which I don't think it does).

If you are just after a generic example there is one in BlueZ source
tree: https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server


-- 
Luiz Augusto von Dentz

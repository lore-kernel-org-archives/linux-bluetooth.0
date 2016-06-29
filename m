Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160627155413.GA5294@arthur-bzh>
References: <20160511125102.GC17904@arthur-bzh> <CABBYNZ+c4mFuBUsR3uzOnMKMKJV-3GXkJiDZESoWzBvnXRg6Yg@mail.gmail.com>
 <20160627155413.GA5294@arthur-bzh>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Wed, 29 Jun 2016 09:20:20 +0200
Message-ID: <CADwkJj+VR=gB6oESpCJ260JYL6_6-knFYM+gZVz6S+sU2DQR1Q@mail.gmail.com>
Subject: Re: gatt server and reset of hci device
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

What version of bluez are you using?

> Is there any example in c using glibdbus ?

Yes you can also look at tools/gatt-service.c for a C example of using
the GATT dbus API.

> * Run bluetoothd with experimental mode enable :
> sudo ./bluetoothd -E

Can you run 'bluetoothd -nE -d src/gatt-database.c'. Do you see
something like 'GATT Manager registered for adapter: /org/bluez/hci0'?

/Tobias

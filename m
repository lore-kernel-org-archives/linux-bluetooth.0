Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 6 Oct 2010 11:53:24 +0200
Message-ID: <AANLkTikqpge1KU4w4aQhtxz21097iQjWTKekdgg_+JeX@mail.gmail.com>
Subject: SCO Socket input.
From: Pepe Aracil <pepe.aracil.gomez@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

If I create SCO socket listening input connections it not works if
bluetoothd is running but if I kill bluetoothd SCO input connections
works fine.

I need bluetoothd running for (mobile rfcomm connection) keys exchange
purposes but I must kill bluetoothd after rfcomm connection if i want
SCO input socket connections works well.

I have compiled bluez without audio support to avoid SCO socket be
blocked by bluetoothd. Without positive results.

¿Some idea?

Thanks

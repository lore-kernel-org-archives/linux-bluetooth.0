Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Tue, 9 Aug 2016 14:37:41 +0100
Message-ID: <CAAu3APYkYEcoO-BG87HYC+Vp5Ke=h2MtWjDJKe-9+e2CG=bg+w@mail.gmail.com>
Subject: Eddystone URL beacon and Peripheral
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am looking to have a Linux single board computer advertising as a
beacon and as a peripheral at the same time through the DBus API.

The use case is that the beacon is a Eddystone URL. That destination
of URL will then use web bluetooth to connect back to the peripheral
service being advertised on the board.

In the BlueZ documentation it states that currently only one
advertisement at a time is supported,
So while it appears multiple UUIDs can be advertised under interface
LEAdvertisement1 it can not be a beacon and a peripheral.

Or am I missing something?

This use case seems like it might become more common with web
bluetooth coming along.
Is it possible to support this under the DBus API?

Thanks,
Barry

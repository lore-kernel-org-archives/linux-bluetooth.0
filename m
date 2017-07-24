Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alvin Lovi <alvinlovi80@gmail.com>
Date: Mon, 24 Jul 2017 13:02:24 +0200
Message-ID: <CANdxJyrU9Ak-h8G8k0cErMknfNt9AnR-T3jEgBt3S5fgWCtu2g@mail.gmail.com>
Subject: Security modes simulation with hciconfig
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
i'm trying to simulate bluetooth devices able to support PIN
pairing/Security mode 1.
I've tried the following commands

hciconfig hci0 sspmode 0
hciconfig hci0 noauth
hciconfig hci0 noencrypt

I thought the above commands were enough but i see this packet after
the pin pairing

host-->controller    "Sent Set Connection Encryption
(0x13)"-Encryption Enable: Link Level Encryption is ON (0x01)

This command should not be sent due to noencrypt/noauth options: is it
true or not?
Thanks,
Alvin

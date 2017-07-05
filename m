Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Ian Molton <ian@mnementh.co.uk>
Subject: bdaddr
Message-ID: <c81eae29-b2bd-f1df-9066-d51591ac6d8f@mnementh.co.uk>
Date: Wed, 5 Jul 2017 20:05:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

When changing the BDADDR why must I down/up the device after doing so?
is it not possible/sensible to change it whilst remaining up?

Could it be possible to allow the BDADDR to be written whilst the device
is down, and inject it when it comes up? Would a patch to do this be
acceptable?

Otherwise, the sequence for programming the BDADDR looks a bit naff;

hciconfig hci0 up
bdaddr -i hci0 <foo>
hciconfig hci0 down
hciconfig hci0 up

To me, it would make more sense if I could do:

hciconfig hci0 down
bdaddr -i hci0 <foo>
hciconfig hci0 up

-Ian

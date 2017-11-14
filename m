Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Julien Massot <massot.julien@gmail.com>
Date: Tue, 14 Nov 2017 12:48:16 +0100
Message-ID: <CAHuuS6G0JCOHUiohpzzskg7x6kib-Y-ToibjX6vf4vTbwYkLcQ@mail.gmail.com>
Subject: AR3011 Device Under Test
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have an usb AR3011 bluetooth chipset in one of my product, and I need to do
some radio testing for certification purpose.

I firstly talked to my bluetooth card vendor to get help, but didn't
had any reply.

Does anyone already succeed to put an AR3011 (managed by ATH3K driver),
under radio test condition ?

So beeing able to do continous Tx, setting the channels, something similar to
tx99 for ath9k:

https://www.spinics.net/lists/linux-wireless/msg113353.html

Thanks a lot for your input.

Regards,
Julien

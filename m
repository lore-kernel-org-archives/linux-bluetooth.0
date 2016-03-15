Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Mar 2016 16:59:44 -0600
Message-ID: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
Subject: setting indication on GattCharacteristic1 interface
From: Mark Rages <markrages@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The GattCharacteristic1 d-bus interface has methods for StartNotify
and StopNotify.

But I don't see corresponding methods for requesting Indications

Is there a way to do this?  Should I write to the CCCD directly?  How
do the indications arrive on the d-bus?

Regards,
Mark
markrages@gmail

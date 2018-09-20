Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACjvaw=rr-MDiBZH6rM1BORBH372ZXLkSrxpPsKjP6dMGo4TZg@mail.gmail.com>
References: <CACjvaw=rr-MDiBZH6rM1BORBH372ZXLkSrxpPsKjP6dMGo4TZg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Sep 2018 12:15:34 +0300
Message-ID: <CABBYNZLTfTLUavm6uELEx-Xvei__+7qv-zb+=ih9ckHUvPmOMw@mail.gmail.com>
Subject: Re: Problem with two dongle simultaneously
To: Nazmul Alam <fadedreamz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nazmul,

On Thu, Sep 20, 2018 at 1:11 AM, Nazmul Alam <fadedreamz@gmail.com> wrote:
> I am trying to run two bluetooth dongles simultaneously for two
> separate devices.
> One device is communicating over classic BT while the other one is using BLE.
> When both devices are running (approximately 250hz sampling rate), the
> BLE is dropping packets (most of the samples are gone).
> I am using pygatt to capture the data and it appears to happen when
> the pygatt chokes and python takes 100% of a single cpu core.
>
> bluetoothctl also shows strange behavior with two controllers. Even
> when a particular controller is selected, it can not show the
> paired-devices correctly, unless the other one is plugged out (the mac
> is different on both dongles).

Try with a more recent version, there were some improvement to handle
multiple adapters better.

> Now, the question is, in bluez is it problematic to run two dongles
> simultaneously considering both of them are active and pushing data?
>
> I am trying to get a more experienced opinion to pinpoint the
> problematic part of the setup (pygatt or bluez).

Btw, pygatt appears to be using gatttool which is deprecated, not idea
why people keep using that.

> bluez - 5.41
> arm64 - kernel 4.4+
> dongles - csr 4.0



-- 
Luiz Augusto von Dentz

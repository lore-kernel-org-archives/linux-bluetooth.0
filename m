Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
References: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
Date: Tue, 31 Dec 2013 14:02:59 +0200
Message-ID: <CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
Subject: Re: BLE for Android
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: bill dr <bilel.dr@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 31, 2013 at 1:47 PM, bill dr <bilel.dr@gmail.com> wrote:
> Hi,
>
> I am trying to port BLE into a 4.1.1 android device.
> I found that bluez git repository contains an android directory.
> Could you explain me or point me to any link or document that explain
> how to use this directory. Is there any HAL implementation already
> done. Or this directory contains only "bluedroid" code ?
>
> Thank you !

Checkout the README:
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README

It is a clean implementation of bluetooth HAL, so no bluedroid code
bellow the HAL interface, above HAL is considered Android itself even
though it may actually contain bluetooth specific bits here and there.
Btw, we are almost ready to start looking at the BLE HAL.



-- 
Luiz Augusto von Dentz

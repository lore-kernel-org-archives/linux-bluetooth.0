Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 10:19:25 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ: HCI_LDISC: Make hci a child of the
 corresponding tty device.
Message-ID: <20110216131925.GC14085@joana>
References: <AANLkTi=77xywyVZmUFrDaRPNnUne+52YYJ5Zh7jAd_3W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=77xywyVZmUFrDaRPNnUne+52YYJ5Zh7jAd_3W@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Warkentin <andreiw@motorola.com> [2011-02-11 17:19:26 -0600]:

> Dear List,
> 
> This depends on Dmitry Eremin-Solenikov's "Tty: add tty_struct->dev
> pointer to corresponding device instance" patch,
> which is in 2.6.37.
> 
> Thanks,
> A

> From 3ae2156afa420f3ba5cb73295037680bdca340f1 Mon Sep 17 00:00:00 2001
> From: Andrei Warkentin <andreiw@motorola.com>
> Date: Fri, 11 Feb 2011 17:59:52 -0600
> Subject: [PATCH] BlueZ: HCI_LDISC: Make hci a child of the corresponding tty device.
> 
> Makes /sys/class/bluetooth/hciX a symlink to
> path under corresponding tty.
> 
> Change-Id: I297361c13c61e2ad82293030553d9f0653e1273a
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/bluetooth/hci_ldisc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Patch has been applied.

-- 
Gustavo F. Padovan
http://profusion.mobi

Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluez 4.68 instant segfault
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100713101007.6da560a1@susi.home.s3e.de>
References: <20100713101007.6da560a1@susi.home.s3e.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 08:49:06 -0300
Message-ID: <1279021746.6282.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> I'd say that this commit would justify an instant 4.69 release:
> 
> commit 86b16d8a63d8d6191533418dd1c38ce35c3fbf0a
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Mon Jul 12 23:59:34 2010 -0300
> 
>     Remove double g_option_context_free() call
> 
> 
> Without that, "bluetoothd --udev" instant segfaults, while without --udev
> it gets aborted by glibc due tot the double free ;)

yes it justify a new release. I am getting to it today.

Regards

Marcel



Return-Path: <cyrus@holtmann.org>
Message-ID: <1332526016.1870.41.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Make L2CAP chan_add functions static
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 23 Mar 2012 11:06:56 -0700
In-Reply-To: <1332513110-10507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332513110-10507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove sparse warnings below:
> 
> ...
> net/bluetooth/l2cap_core.c:302:6: warning: symbol '__l2cap_chan_add' was
> not declared. Should it be static?
> net/bluetooth/l2cap_core.c:351:6: warning: symbol 'l2cap_chan_add' was
> not declared. Should it be static?
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



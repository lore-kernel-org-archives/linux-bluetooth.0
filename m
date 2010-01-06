Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] DFU Driver for Atheros bluetooth chipset AR3011
From: Marcel Holtmann <marcel@holtmann.org>
To: Kandukuri Vikram <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrodriguez@atheros.com
In-Reply-To: <20100106133415.GC13153@atheros-laptop>
References: <20100106133415.GC13153@atheros-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jan 2010 12:57:56 -0800
Message-ID: <1262811476.16627.402.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> Signed-off-by: Vikram Kandukuri <vikram.kandukuri@atheros.com>
> Signed-off-by: Alicke Xu <sxu@atheros.com>
> Reviewed-by: Luis R. Rodriguez <lrodriguez@atheros.com>
> ---
>  drivers/bluetooth/Kconfig  |   13 +++-
>  drivers/bluetooth/Makefile |    1 +
>  drivers/bluetooth/ath3k.c  |  187 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/bluetooth/ath3k.c

patch has been applied to my trees.

However I still had to hand edit in various small ares. For example
BT_DBG doesn't require the \n newline. So you have never actually tested
the debug code. Otherwise you would have seen that something is off.
Also there were still a bunch of spaces in the code that I had to fix
manually.

Also I prefer if you a bit more consistent writing "Bluetooth" exactly
this way in comment and descriptions. It is brand name and the writing
is suppose to be consistent.

Regards

Marcel



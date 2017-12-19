Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ 3/4] lib: Introduce bt_appeartostr
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171219124059.4466-3-luiz.dentz@gmail.com>
Date: Tue, 19 Dec 2017 18:29:33 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5F8872D1-8947-4AA0-9F73-808D8A9D4440@holtmann.org>
References: <20171219124059.4466-1-luiz.dentz@gmail.com>
 <20171219124059.4466-3-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds bt_appeartostr which can decode the appearance code to a
> human readable string.
> ---
> lib/bluetooth.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> lib/bluetooth.h |  1 +
> 2 files changed, 88 insertions(+)
> 
> diff --git a/lib/bluetooth.c b/lib/bluetooth.c
> index 3276b68a5..75d94dbfa 100644
> --- a/lib/bluetooth.c
> +++ b/lib/bluetooth.c

I really do not want to extend libbluetooth.so anymore with new functionality. If you want to do some things in src/shared/ then fine, but nothing is going to move into lib/ anymore.

Regards

Marcel


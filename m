Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160909122720.2404-1-tobias.svehagen@gmail.com>
References: <20160909122720.2404-1-tobias.svehagen@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Sep 2016 17:31:22 +0300
Message-ID: <CABBYNZ+UZiFDmzZOLTyutiAVOa9Y7wYhVNNDpDYZ9tEnwR9niw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/device: Use BT_ATT_DEFAULT_LE_MTU as default MTU
To: Tobias Svehagen <tobias.svehagen@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Fri, Sep 9, 2016 at 3:27 PM, Tobias Svehagen
<tobias.svehagen@gmail.com> wrote:
> Use the default MTU until an MTU exchange has taken place and
> something else has been negotiated. If either side does not support
> MTU exchange, the connection shall continue to use this default
> value instead of the device maximum which was the previous behavior.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 9586022..ea36848 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4778,7 +4778,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>         }
>
>         dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> -       attrib = g_attrib_new(io, dev->att_mtu, false);
> +       attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);


This is not complete right since latter on if the MTU is negotiated by
bt_gatt_client, but I remember fixing something like this:

commit 64f864173393f6e750a94b895f39119ca80b93df
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 12 16:18:45 2015 +0200

    attrib: Fix not honoring MTU

    If MTU has changed, by bt_gatt_client for example, the code should be
    able to figure it out without waiting g_attrib_set_mtu to be called.

Btw, it would be good to have some logs what exactly is the scenario
where this happens.

-- 
Luiz Augusto von Dentz

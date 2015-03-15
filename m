Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
References: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 15 Mar 2015 09:05:52 +0200
Message-ID: <CABBYNZLHxk+KC31052hquQNBDDp0281y1T2F+7xc1GHMMtwFRw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] attrib: Fix not honoring MTU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 13, 2015 at 10:54 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If MTU has changed, by bt_gatt_client for example, the code should be
> able to figure it out without waiting g_attrib_set_mtu to be called.
> ---
>  attrib/gattrib.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 514fc8f..2011359 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -429,9 +429,24 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
>
>  uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
>  {
> +       uint16_t mtu;
> +
>         if (!attrib || !len)
>                 return NULL;
>
> +       mtu = bt_att_get_mtu(attrib->att);
> +
> +       /*
> +        * Clients of this expect a buffer to use.
> +        *
> +        * Pdu encoding in shared/att verifies if whole buffer fits the mtu,
> +        * thus we should set the buflen also when mtu is reduced. But we
> +        * need to reallocate the buffer only if mtu is larger.
> +        */
> +       if (mtu > attrib->buflen)
> +               attrib->buf = g_realloc(attrib->buf, mtu);
> +
> +       attrib->buflen = mtu;
>         *len = attrib->buflen;
>         return attrib->buf;
>  }
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180319105841.32436-1-robert.lubas@silvair.com>
References: <20180319105841.32436-1-robert.lubas@silvair.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Mar 2018 17:04:06 +0200
Message-ID: <CABBYNZLspQfEFNWmi6HuJ4PLuNck7e7whSzE0jxFrwfboTtMpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Mesh: Fix proxy PDU SAR msg length
To: =?UTF-8?Q?Robert_Luba=C5=9B?= <robert.lubas@silvair.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,

On Mon, Mar 19, 2018 at 12:58 PM, Robert Luba=C5=9B <robert.lubas@silvair.c=
om> wrote:
> In read_pipe function there was a mishandled case when the msg has
> more than one segment. As a result e.g. after provisioning the
> capabilities discovery was incorrect parsed.
> ---
>  mesh/gatt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mesh/gatt.c b/mesh/gatt.c
> index 9116a9de1..693577a3a 100644
> --- a/mesh/gatt.c
> +++ b/mesh/gatt.c
> @@ -383,7 +383,7 @@ static bool pipe_read(struct io *io, bool prov, void =
*user_data)
>         uint8_t buf[512];
>         uint8_t *res;
>         int fd =3D io_get_fd(io);
> -       ssize_t len;
> +       ssize_t len, len_sar;
>
>         if (io !=3D notify_io)
>                 return true;
> @@ -393,14 +393,14 @@ static bool pipe_read(struct io *io, bool prov, voi=
d *user_data)
>                         break;
>
>                 res =3D buf;
> -               mesh_gatt_sar(&res, len);
> -
> -               if (prov)
> -                       prov_data_ready(node, res, len);
> -               else
> -                       net_data_ready(res, len);
> +               len_sar =3D mesh_gatt_sar(&res, len);
> +               if (len_sar) {
> +                       if (prov)
> +                               prov_data_ready(node, res, len_sar);
> +                       else
> +                               net_data_ready(res, len_sar);
> +               }
>         }
> -
>         return true;
>  }
>
> --
> 2.11.0

Applied, thanks.

--=20
Luiz Augusto von Dentz

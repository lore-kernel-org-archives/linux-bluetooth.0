Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACgnnkmivLGAy7_YkoRgWCNR61rvr3CnQWNfKOWAWrBy4iRadA@mail.gmail.com>
References: <CACgnnk=4aQiprXz1iY33kmPf2jYT=pPzr4c20N1n4Xt7m4322Q@mail.gmail.com>
 <CABBYNZ+ZntY4vr-Sk9OLtgvdgGRazzaFzpK5G3r+X0tZq4G10g@mail.gmail.com> <CACgnnkmivLGAy7_YkoRgWCNR61rvr3CnQWNfKOWAWrBy4iRadA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Mar 2018 07:51:24 +0200
Message-ID: <CABBYNZJ+xYukPE0nY_VkfVqOF1tvHMHFE5-_Z_vNQ815H59dMw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Fix proxy PDU SAR msg length
To: =?UTF-8?Q?Robert_Luba=C5=9B?= <robert.lubas@silvair.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,

On Fri, Mar 16, 2018 at 11:56 AM, Robert Luba=C5=9B <robert.lubas@silvair.c=
om> wrote:
> Assignment outside if statement.
> ---
>  mesh/gatt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mesh/gatt.c b/mesh/gatt.c
> index 9116a9de1..693577a3a 100644
> --- a/mesh/gatt.c
> +++ b/mesh/gatt.c
> @@ -383,7 +383,7 @@ static bool pipe_read(struct io *io, bool prov,
> void *user_data)
>         uint8_t buf[512];
>         uint8_t *res;
>         int fd =3D io_get_fd(io);
> -       ssize_t len;
> +       ssize_t len, len_sar;
>
>         if (io !=3D notify_io)
>                 return true;
> @@ -393,14 +393,14 @@ static bool pipe_read(struct io *io, bool prov,
> void *user_data)
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

Looks like you responded with the new patch instead of sending just
the changes an as a result I cannot apply the patch with git am,
perhaps you are not using git format-patch + git send-email?

> 2018-03-16 9:36 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>
>> Hi Robert,
>>
>> On Fri, Mar 16, 2018 at 10:14 AM, Robert Luba=C5=9B <robert.lubas@silvai=
r.com> wrote:
>> > In read_pipe function there was a mishandled case when the msg has
>> > more than one segment. As a result e.g. after provisioning the
>> > capabilities discovery was incorrect parsed.
>> >
>> > ---
>> >  mesh/gatt.c | 15 +++++++--------
>> >  1 file changed, 7 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/mesh/gatt.c b/mesh/gatt.c
>> > index 9116a9de1..8fecac10b 100644
>> > --- a/mesh/gatt.c
>> > +++ b/mesh/gatt.c
>> > @@ -383,7 +383,7 @@ static bool pipe_read(struct io *io, bool prov,
>> > void *user_data)
>> >         uint8_t buf[512];
>> >         uint8_t *res;
>> >         int fd =3D io_get_fd(io);
>> > -       ssize_t len;
>> > +       ssize_t len, len_sar;
>> >
>> >         if (io !=3D notify_io)
>> >                 return true;
>> > @@ -393,14 +393,13 @@ static bool pipe_read(struct io *io, bool prov,
>> > void *user_data)
>> >                         break;
>> >
>> >                 res =3D buf;
>> > -               mesh_gatt_sar(&res, len);
>> > -
>> > -               if (prov)
>> > -                       prov_data_ready(node, res, len);
>> > -               else
>> > -                       net_data_ready(res, len);
>> > +               if (len_sar =3D mesh_gatt_sar(&res, len)) {
>>
>> Leave the assignment outside of if statement like:
>>
>> len_sar =3D...
>> if (len_sar)...
>>
>> > +                       if (prov)
>> > +                               prov_data_ready(node, res, len_sar);
>> > +                       else
>> > +                               net_data_ready(res, len_sar);
>> > +               }
>> >         }
>> > -
>> >         return true;
>> >  }
>>
>> Other than that it looks fine.
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

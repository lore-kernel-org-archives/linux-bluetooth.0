Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 9 Dec 2014 09:44:24 +0100
Message-ID: <CAMudyAstnmV4JCxc8=7RrBnhGZ=XEH7fgysbkw53uCRTvHx0Xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] attrib/gatt.c: Fix for attrib ref
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 9 December 2014 at 09:40, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> This patch makes sure that attrib instance will not disappear while
> reading characteristic

Just noticed that there is small issue in the commit msg. Should be
"attrib/gatt" instead of "attrib/gatt.c" :) Please fix when pushing or
let me know so I will send v2.

\Lukasz
> ---
>  attrib/gatt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index f8ff2a5..0e633f7 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -673,6 +673,8 @@ static void read_long_destroy(gpointer user_data)
>         if (__sync_sub_and_fetch(&long_read->ref, 1) > 0)
>                 return;
>
> +       g_attrib_unref(long_read->attrib);
> +
>         if (long_read->buffer != NULL)
>                 g_free(long_read->buffer);
>
> @@ -776,7 +778,7 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
>         if (long_read == NULL)
>                 return 0;
>
> -       long_read->attrib = attrib;
> +       long_read->attrib = g_attrib_ref(attrib);
>         long_read->func = func;
>         long_read->user_data = user_data;
>         long_read->handle = handle;
> @@ -785,9 +787,10 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
>         plen = enc_read_req(handle, buf, buflen);
>         id = g_attrib_send(attrib, 0, buf, plen, read_char_helper,
>                                                 long_read, read_long_destroy);
> -       if (id == 0)
> +       if (id == 0) {
> +               g_attrib_unref(long_read->attrib);
>                 g_free(long_read);
> -       else {
> +       } else {
>                 __sync_fetch_and_add(&long_read->ref, 1);
>                 long_read->id = id;
>         }
> --
> 1.8.4
>

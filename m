Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Date: Tue, 4 Nov 2014 14:53:22 -0200
Message-ID: <CABaesJKLmr6QOx=m8HpVEG4J0gEn0Tkn1CFU4QMrhrx0tjDCVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] lib: Change bluetooth.h to compile in strict C
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Tue, Oct 28, 2014 at 3:03 PM, Gabriel Souza Franco
<gabrielfrancosouza@gmail.com> wrote:
>
> ---
>
> This change enables programs written with strict C syntax
> (e.g. "-std=c11 -pedantic") to compile when including
> bluetooth.h.
>
> v2: Resend with fixed commits.
>
>  lib/bluetooth.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 61c1f9a..f214d81 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -156,18 +156,18 @@ enum {
>
>  /* Bluetooth unaligned access */
>  #define bt_get_unaligned(ptr)                  \
> -({                                             \
> +__extension__ ({                               \
>         struct __attribute__((packed)) {        \
> -               typeof(*(ptr)) __v;             \
> -       } *__p = (typeof(__p)) (ptr);           \
> +               __typeof__(*(ptr)) __v;         \
> +       } *__p = (__typeof__(__p)) (ptr);       \
>         __p->__v;                               \
>  })
>
>  #define bt_put_unaligned(val, ptr)             \
>  do {                                           \
>         struct __attribute__((packed)) {        \
> -               typeof(*(ptr)) __v;             \
> -       } *__p = (typeof(__p)) (ptr);           \
> +               __typeof__(*(ptr)) __v;         \
> +       } *__p = (__typeof__(__p)) (ptr);       \
>         __p->__v = (val);                       \
>  } while(0)
>
> --
> 2.1.2
>

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: rohan16garg@gmail.com
In-Reply-To: <1328439464.32199.22.camel@pohly-mobl1.fritz.box>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
 <1326705845.6454.274.camel@aeonflux> <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
 <1328439363.32199.20.camel@pohly-mobl1.fritz.box> <1328439464.32199.22.camel@pohly-mobl1.fritz.box>
From: Rohan Garg <rohangarg@ubuntu.com>
Date: Sun, 5 Feb 2012 16:37:59 +0530
Message-ID: <CAEb1ZdjO3W5xUkU3t+CSpVn1u=OCGwBLLeUyvfG-_WMR5AXWxQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue in C++ with ifdef
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com, Tino Keitel <tino.keitel+syncevolution@tikei.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

I've not gone through the entire patch, but if the problem is merely
the fact that one cannot convert a void* to anything in C++, why not
use a static_cast in syncevolution wherever the struct is used?

Best
Rohan Garg



On Sun, Feb 5, 2012 at 4:27 PM, Patrick Ohly <patrick.ohly@intel.com> wrote=
:
> The compiler error is:
> =C2=A0/usr/include/bluetooth/bluetooth.h::131:9:=E2=80=82error:=E2=80=82i=
nvalid=E2=80=82conversion from=E2=80=82'void*'=E2=80=82to=E2=80=82'bt_get_l=
e64(void*)::<anonymous=E2=80=82struct>*'
> =C2=A0...
>
> The reason is that C++, in contrast to C, does not allow conversion of
> void * to anything, and this code gets compiled as C++ when the app is
> written in C++. The macro with the assignment itself is older, but only
> recent Bluez starts to use it in inline functions, thus triggering the
> problem.
>
> This patch keeps the "struct __attribute__((packed))" magic and merely
> changes the typecast so that it works in C and C++. Like the existing
> macro this patch relies on support for typeof.
>
> The new variant of the code is in an ifdef and only used for C++
> to avoid unexpected regressions in C applications.
>
> Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
> ---
> =C2=A0lib/bluetooth.h | =C2=A0 30 ++++++++++++++++++++++++++++++
> =C2=A01 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 5bd4f03..3293915 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -109,6 +109,11 @@ enum {
> =C2=A0#endif
>
> =C2=A0/* Bluetooth unaligned access */
> +#ifndef __cplusplus
> +/*
> + * traditional code, doesn't work in C++ because
> + * of the void * to struct pointer assignment
> + */
> =C2=A0#define bt_get_unaligned(ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0({ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct __attribute__((packed)) { =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
> @@ -125,6 +130,31 @@ do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__p->__v =3D (val); =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0} while(0)
>
> +#else /* __cplusplus */
> +
> +/*
> + * modified code with typeof typecast, for C++;
> + * the traditional code continues to be used for
> + * C to avoid unexpected regressions with this
> + * code here (it should work in C and C++, though)
> + */
> +#define bt_get_unaligned(ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\
> +({ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 struct __attribute__((packed)) { =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeof(*(ptr)) __v; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 } *__p =3D (typeof(__p)) (ptr); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 __p->__v; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> +})
> +
> +#define bt_put_unaligned(val, ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \
> +do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 struct __attribute__((packed)) { =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeof(*(ptr)) __v; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 } *__p =3D (typeof(__p)) (ptr); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 __p->__v =3D (val); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> +} while(0)
> +#endif /* __cplusplus */
> +
> =C2=A0#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> =C2=A0static inline uint64_t bt_get_le64(void *ptr)
> =C2=A0{
> --
> 1.7.8.3
>
>
>

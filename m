Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Jan 2014 18:06:24 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Donald Carr <sirspudd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Compilation using clang
Message-ID: <20140110200624.GA25318@molly.amr.corp.intel.com>
References: <CAOVeLGSGAf9LmsEcaAiECh+zL-7bg-gZJnue4TqzbBCNFfMj3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAOVeLGSGAf9LmsEcaAiECh+zL-7bg-gZJnue4TqzbBCNFfMj3w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Donald,

On 09:57 Fri 10 Jan, Donald Carr wrote:
> Top of the morning,
>
> qtconnectivity currently contains a kludge which is required due to
> the use of the GCC typeof extension in bluetooth.h which is breaking
> with Clang compilation against the cxx11 spec.

Another kludge that I have seen is putting a
"#define typeof(x) __tupeof__(x)" before including bluetooth.h.

>
> The kludge in question involves molesting the standard (eg -std=cxx11)
> specified to the compiler (explicitly away from cxx11 toward g++0x)
> and hence I am hoping to be able to murder its intrusive self. I am
> not entirely clear on the nuances though:
>
> This is the offending section:
>
> #define bt_get_unaligned(ptr)                   \
> ({                                              \
>         struct __attribute__((packed)) {        \
>                 typeof(*(ptr)) __v;         \
>         } *__p = (typeof(__p)) (ptr);               \
>         __p->__v;                               \
> })
>
> #define bt_put_unaligned(val, ptr)              \
> do {                                            \
>         struct __attribute__((packed)) {        \
>                 typeof(*(ptr)) __v;         \
>         } *__p = (typeof(__p)) (ptr);               \
>         __p->__v = (val);                       \
> } while(0)
>
> and changing typeof to __typeof__ has been verified to succeed in the
> stated circumstance. I don't know whether this is the ideal solution,
> or whether decltype or so other designator would be a closer/better
> match.

I would vote for changing it to __typeof__.

>
> Any feedback would be greatly appreciated, I am using this change
> locally and I think it could be of broader use to people.

Please send a patch and let's see what others think.

>
> Yours sincerely,
> Donald Carr
>
>
> --
> -------------------------------
>  °v°  Donald Carr
> /(_)\ Vaguely Professional Penguin lover
>  ^ ^
>
> Cave canem, te necet lingendo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius

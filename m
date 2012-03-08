Return-Path: <cyrus@holtmann.org>
Message-ID: <1331229077.14217.9.camel@aeonflux>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Marcel Holtmann <marcel@holtmann.org>
To: Markus Rathgeb <maggu2810@googlemail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Patrick Ohly <patrick.ohly@intel.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 08 Mar 2012 09:51:17 -0800
In-Reply-To: <CAOcK=CO9au1DnBCw-9bik+nnuOdptNVBpStRVWjdOUaj55xHHg@mail.gmail.com>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	 <1330903638.3392.141.camel@aeonflux>
	 <CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
	 <CAOcK=CO9au1DnBCw-9bik+nnuOdptNVBpStRVWjdOUaj55xHHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

please do not top post on this mailing list.

> Why can't we get rid off the "typeof" keyword completely and using a
> template similar approach:
> 
> ===
> 
> #define bt_get_unaligned_tmpl(type, ptr)         \
> ({                                               \
>        struct __p_s  {                           \
>                type __v;                         \
>        } __attribute__((packed));                \
>        struct __p_s *__p = (struct __p_s*)(ptr); \
>        __p->__v;                                 \
> })
> 
> static inline uint64_t bt_get_le64(void *ptr)
> {
> 	return bt_get_unaligned_tmpl(uint64_t, ptr);
> }
> 
> static inline uint64_t bt_get_be64(void *ptr)
> {
> 	return bswap_64(bt_get_unaligned_tmpl(uint64_t, ptr));
> }
> 
> ===
> 
> Okay, the macro parameter type is not encapsulated by parenthesis, but
> it seems okay and working.
> So it seems to be a very more portable solution (IMHO).

what does seems okay and working actually mean? Have you actually
verified on platform that require correct unaligned access to data?

Regards

Marcel



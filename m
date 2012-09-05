Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v4 15/18] Refactor bt_get_unaligned macro
Date: Wed, 5 Sep 2012 11:03:29 +0200
Message-ID: <5709985.AIy78rkvT5@uw000953>
In-Reply-To: <1346772105.21200.2.camel@aeonflux>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com> <1346769697-9930-16-git-send-email-szymon.janc@tieto.com> <1346772105.21200.2.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 04 of September 2012 18:21:45 Marcel Holtmann wrote:
> Hi Szymon,

Hi Marcel,

> 
> > Use extra parameter type for bt_get_unaligned to avoid pointer casting
> > which might trigger compile time errors due to unaligned memory access.
> > 
> > ---
> >  attrib/att.h       |    6 +++---
> >  lib/bluetooth.h    |   28 ++++++++++++++--------------
> >  lib/sdp.c          |   22 +++++++++++-----------
> >  src/sdpd-request.c |    4 ++--
> >  4 files changed, 30 insertions(+), 30 deletions(-)
> > 
> > diff --git a/attrib/att.h b/attrib/att.h
> > index a563255..6101dac 100644
> > --- a/attrib/att.h
> > +++ b/attrib/att.h
> > @@ -115,19 +115,19 @@ struct att_range {
> >  static inline uint8_t att_get_u8(const void *ptr)
> >  {
> >  	const uint8_t *u8_ptr = ptr;
> > -	return bt_get_unaligned(u8_ptr);
> > +	return bt_get_unaligned(u8_ptr, uint8_t);
> >  }
> >  
> >  static inline uint16_t att_get_u16(const void *ptr)
> >  {
> >  	const uint16_t *u16_ptr = ptr;
> > -	return btohs(bt_get_unaligned(u16_ptr));
> > +	return btohs(bt_get_unaligned(u16_ptr, uint16_t));
> >  }
> >  
> >  static inline uint32_t att_get_u32(const void *ptr)
> >  {
> >  	const uint32_t *u32_ptr = ptr;
> > -	return btohl(bt_get_unaligned(u32_ptr));
> > +	return btohl(bt_get_unaligned(u32_ptr, uint32_t));
> >  }
> >  
> >  static inline uint128_t att_get_u128(const void *ptr)
> > diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> > index 161b7bd..898a122 100644
> > --- a/lib/bluetooth.h
> > +++ b/lib/bluetooth.h
> > @@ -137,10 +137,10 @@ enum {
> >  #endif
> >  
> >  /* Bluetooth unaligned access */
> > -#define bt_get_unaligned(ptr)			\
> > +#define bt_get_unaligned(ptr, type)		\
> >  ({						\
> >  	struct __attribute__((packed)) {	\
> > -		typeof(*(ptr)) __v;		\
> > +		type __v;			\
> >  	} *__p = (typeof(__p)) (ptr);		\
> >  	__p->__v;				\
> >  })
> 
> I am not in favor of this change at all. We should not need such a
> change. And in addition, it break the API.

On ARM (and possibly other architectures) with -Wcast-align one is not able to do:
uint8_t *ptr;
uint16_t *ptr2 = (uint16_t *)ptr;
int *ptr3 = (int *)ptr;
etc.

It leads to following error:
error: cast increases required alignment of target type [-Werror=cast-align]

..and this is what current version of that macro requires.
(BTW bt_put_unaligned suffers same issue)

In bluetoothd code we can replace all calls to that macro with (more or less
convenient) memcpy. But if that macro is considered part of API it may produce
compilation errors on projects that use -Wcast-align.

Any suggestions on how this could be solved are welcome.


> Regards
> 
> Marcel
> 

-- 
BR
Szymon Janc

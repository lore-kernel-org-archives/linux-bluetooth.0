Return-Path: <cyrus@holtmann.org>
Message-ID: <1330932819.4028.59.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Patrick Ohly <patrick.ohly@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Mar 2012 08:33:39 +0100
In-Reply-To: <1330903638.3392.141.camel@aeonflux>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	 <1330903638.3392.141.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-03-04 at 15:27 -0800, Marcel Holtmann wrote:
> Hi Patrick,
> 
> > The compiler error is:
> >  /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
> >  ...
> > 
> > The reason is that C++, in contrast to C, does not allow conversion of
> > void * to anything, and this code gets compiled as C++ when the app is
> > written in C++. The macro with the assignment itself is older, but only
> > recent Bluez starts to use it in inline functions, thus triggering the
> > problem.
> > 
> > This patch keeps the "struct __attribute__((packed))" magic and merely
> > changes the typecast so that it works in C and C++. Like the existing
> > macro this patch relies on support for typeof.
> 
> so I am applying this patch now, but I still have no idea what kind of
> stupid C++ compiler you are using.

The default g++ as used by affected distros.

>  The section of this include is
> clearly marked as C code:
> 
> #ifdef __cplusplus
> extern "C" {
> #endif

That doesn't mean that the C++ compiler falls back to C mode. It merely
uses C names for the symbols in that section.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.

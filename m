Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Mon, 2 Feb 2009 13:11:00 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200901290310.03440.siarhei.siamashka@nokia.com> <1233214058.2139.6.camel@violet>
In-Reply-To: <1233214058.2139.6.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902021311.00204.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 29 January 2009 09:27:38 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > The attached patch contains optimization for scale factors calculation
> > which provides additional SBC encoder speedup.
> >
> > For non-gcc compilers, CLZ function is implemented with a very simple and
> > slow straightforward code (but it is still faster than current git code
> > even if used instead of __builtin_clz). Something better could be done
> > like:
> > http://groups.google.com/group/comp.sys.arm/msg/5ae56e3a95a2345e?hl=en
> > But I'm not sure about license/copyright of the code at this link and
> > decided not to touch it. Anyway, I don't think that gcc implementation of
> > __builtin_clz for the CPU cores which do not support CLZ instruction is
> > any worse.
>
> personally I don't really care about non-gcc compilers. I think that
> some of the BlueZ source might not even compile without gcc.

At least for the SBC codec, there is no harm in trying to keep it as portable
as it is possible. Somebody might want to compile it with some other, better
optimizing compiler and link with the rest of gcc compiled bluez. Or SBC
processing can be offloaded to DSP (C55x port exists) with the rest of bluez
stack running on main core.

> Anyway, patch has been applied. Thanks.

Thanks for applying it.

-- 
Best regards,
Siarhei Siamashka

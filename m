Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with
 __builtin_clz
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901290310.03440.siarhei.siamashka@nokia.com>
References: <200901290310.03440.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 08:27:38 +0100
Message-Id: <1233214058.2139.6.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> The attached patch contains optimization for scale factors calculation which
> provides additional SBC encoder speedup.
> 
> For non-gcc compilers, CLZ function is implemented with a very simple and
> slow straightforward code (but it is still faster than current git code even
> if used instead of __builtin_clz). Something better could be done like: 
> http://groups.google.com/group/comp.sys.arm/msg/5ae56e3a95a2345e?hl=en
> But I'm not sure about license/copyright of the code at this link and decided
> not to touch it. Anyway, I don't think that gcc implementation of
> __builtin_clz for the CPU cores which do not support CLZ instruction is any
> worse.

personally I don't really care about non-gcc compilers. I think that
some of the BlueZ source might not even compile without gcc.

Anyway, patch has been applied. Thanks.

Regards

Marcel



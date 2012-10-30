Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121030034633.2242d317@i7>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028020621.3653ac8e@i7>
	<20121028022942.3bcd1bd7@i7>
	<CA+QXtDvsWoQd+JVxKC0HVRGZxUKg-JeN7_V+MfHXotg_N6EBKQ@mail.gmail.com>
	<20121030034633.2242d317@i7>
Date: Tue, 30 Oct 2012 06:26:57 +0100
Message-ID: <CA+QXtDtvyZ7yLw5a0GMsHZN9Z2SR7g1yAkXXqVt6ZijSh8M=8w@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Tue, Oct 30, 2012 at 2:46 AM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Mon, 29 Oct 2012 08:42:08 +0100
> "Dalleau, Frederic" <frederic.dalleau@intel.com> wrote:

> So I still think that it is safer and cleaner to have
> "sbc_init_primitives" function performing the following in order:
> 1. Initialize function pointers with C implementations.
> 2. Allow to override them with various platform specific
> implementations (which would work fine for old SBC formats).
> 3. At the end of the function have a check if we are actually dealing
> with mSBC format and restore all the function pointers back to C
> implementations in this case.

That's only ok for simd, but as soon as mmx gets in there would be
a 4th category where implementation supporting msbc would override
the already defined pointer.

Imho, the definitive clean solution is to add the missing primitives.

> Well, I just don't quite like that after the patches
>     [PATCH 04/10] sbc: Add msbc flag and generic C primitive
>     [PATCH 05/10] sbc: Add support for mSBC frame header
> we already have a complete mSBC support in C code, which is still
> unusable (as in buggy) if run on mmx, iwmmxt, armv6 or arm neon capable
> systems.

This is experimental feature and the time of commit, it is unused.
And btw, you just suggested to split this patch, and this will also lead to a
transitional state where some new functionality can be broken.

> The sbc-1.0 library is already starting to get packaged in some linux
> distributions. If somebody tries to run some application to do mSBC
> encoding/decoding, but happens to have an old sbc-1.0 library in his

I may be mistaking but most projects uses sbc statically, so checking is mostly
done at compile time. So as I often hear in open source : we'll cross the bridge
when we get to it :)

Regards,
Frédéric

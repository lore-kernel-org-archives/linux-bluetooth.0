Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+CvcKS22JJAF=bH09NLP_8OZyJeKac=qSCn9rNyOU2x5Ezegw@mail.gmail.com>
References: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
	<CACY+gR1+G-PgxfYt7pmuUyLdOAx4-N60S+VuaO4NcmWZ1300Ww@mail.gmail.com>
	<CA+CvcKS22JJAF=bH09NLP_8OZyJeKac=qSCn9rNyOU2x5Ezegw@mail.gmail.com>
Date: Tue, 6 Sep 2011 14:33:46 +0300
Message-ID: <CACY+gR2sYTYib+OATmShkMKuEEqgAxSmyqFBD7KXe8dgCP19PA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] sbc: Use __asm__ keyword
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 6, 2011 at 1:02 PM, Maarten Bosmans <mkbosmans@gmail.com> wrote:
> 2011/9/6 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> On Tue, Sep 6, 2011 at 10:40 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Maarten Bosmans <mkbosmans@gmail.com>
>>>
>>> ---
>>>  sbc/sbc_primitives_armv6.c  |    4 ++--
>>>  sbc/sbc_primitives_iwmmxt.c |    4 ++--
>>>  sbc/sbc_primitives_mmx.c    |   14 +++++++-------
>>>  sbc/sbc_primitives_neon.c   |   28 ++++++++++++++--------------
>>>  4 files changed, 25 insertions(+), 25 deletions(-)
>>
>> Not that I'm opposing this change, but having some rationale and
>> explanations in the commit message would be nice.
>
> First: consistency. __asm__ was already used elsewhere in the files,
> so using that throughout is cleaner.

This argument alone is only about cosmetics. It would be not very good
to end up flipping between '__asm__' vs. 'asm' back and forth if
somebody aesthetically does not like the underscores, or some legacy
version of gcc or the other compiler fails to work with '__asm__' but
works with 'asm', etc.

> Second: both asm and __asm__ are GCC-specific extensions, not defined
> in the C standard. When compiling with --std=gnu99 both are
> recognized, but when using --std=c99 only __asm__ is recognized to
> make it perfectly clear that you're not using some standard C99
> construct, but a GCC-extension.

This whole inline assembly code in question is not defined in the C
standard. It is gcc specific, or at least specific for the use with
the compilers which claim to be gcc compatible and provide __GNUC_
define. Does the use of 'asm' instead of '__asm__' already cause some
problems somewhere? Like has somebody switched to using '--std=c99'
option or maybe going to use it soon?

Right now it is not obvious whether this is a bugfix or cosmetics by
just looking at the commit message. That's why I wanted to clarify
these additional details. The informative commit message could provide
a great deal of information to the one who might need to change this
code in the future or would like to back out your patch for whatever
reason.

-- 
Best regards,
Siarhei Siamashka

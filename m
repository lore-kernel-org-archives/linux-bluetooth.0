Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR1+G-PgxfYt7pmuUyLdOAx4-N60S+VuaO4NcmWZ1300Ww@mail.gmail.com>
References: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
	<CACY+gR1+G-PgxfYt7pmuUyLdOAx4-N60S+VuaO4NcmWZ1300Ww@mail.gmail.com>
Date: Tue, 6 Sep 2011 12:02:32 +0200
Message-ID: <CA+CvcKS22JJAF=bH09NLP_8OZyJeKac=qSCn9rNyOU2x5Ezegw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] sbc: Use __asm__ keyword
From: Maarten Bosmans <mkbosmans@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/9/6 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> On Tue, Sep 6, 2011 at 10:40 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Maarten Bosmans <mkbosmans@gmail.com>
>>
>> ---
>>  sbc/sbc_primitives_armv6.c  |    4 ++--
>>  sbc/sbc_primitives_iwmmxt.c |    4 ++--
>>  sbc/sbc_primitives_mmx.c    |   14 +++++++-------
>>  sbc/sbc_primitives_neon.c   |   28 ++++++++++++++--------------
>>  4 files changed, 25 insertions(+), 25 deletions(-)
>
> Not that I'm opposing this change, but having some rationale and
> explanations in the commit message would be nice.

First: consistency. __asm__ was already used elsewhere in the files,
so using that throughout is cleaner.

Second: both asm and __asm__ are GCC-specific extensions, not defined
in the C standard. When compiling with --std=gnu99 both are
recognized, but when using --std=c99 only __asm__ is recognized to
make it perfectly clear that you're not using some standard C99
construct, but a GCC-extension.

Maarten

Maarten

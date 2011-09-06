Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
References: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 6 Sep 2011 11:40:53 +0300
Message-ID: <CACY+gR1+G-PgxfYt7pmuUyLdOAx4-N60S+VuaO4NcmWZ1300Ww@mail.gmail.com>
Subject: Re: [PATCH BlueZ] sbc: Use __asm__ keyword
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Maarten Bosmans <mkbosmans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 6, 2011 at 10:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Maarten Bosmans <mkbosmans@gmail.com>
>
> ---
>  sbc/sbc_primitives_armv6.c  |    4 ++--
>  sbc/sbc_primitives_iwmmxt.c |    4 ++--
>  sbc/sbc_primitives_mmx.c    |   14 +++++++-------
>  sbc/sbc_primitives_neon.c   |   28 ++++++++++++++--------------
>  4 files changed, 25 insertions(+), 25 deletions(-)

Not that I'm opposing this change, but having some rationale and
explanations in the commit message would be nice.

-- 
Best regards,
Siarhei Siamashka

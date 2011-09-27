Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:23:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] sbc: Use __asm__ keyword
Message-ID: <20110927082356.GC3952@dell>
References: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315294844-28020-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 06, 2011, Luiz Augusto von Dentz wrote:
> From: Maarten Bosmans <mkbosmans@gmail.com>
> 
> ---
>  sbc/sbc_primitives_armv6.c  |    4 ++--
>  sbc/sbc_primitives_iwmmxt.c |    4 ++--
>  sbc/sbc_primitives_mmx.c    |   14 +++++++-------
>  sbc/sbc_primitives_neon.c   |   28 ++++++++++++++--------------
>  4 files changed, 25 insertions(+), 25 deletions(-)

Applied. Thanks.

Johan

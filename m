Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 10:32:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] SBC encoder optimizations (scale factors)
Message-ID: <20100630073239.GA23270@jh-x301>
References: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Tue, Jun 29, 2010, Siarhei Siamashka wrote:
> Some patches for making SBC encoding up to 10% faster on ARM and x86.
> 
> Also available in git://gitorious.org/system-performance/bluez-sbc.git
> branch 'sbc-fast-scalefactors-for-master'
> 
> Siarhei Siamashka (3):
>   sbc: new 'sbc_calc_scalefactors_j' function added to sbc primitives
>   sbc: MMX optimization for scale factors calculation
>   sbc: ARM NEON optimization for scale factors calculation
> 
>  sbc/sbc.c                 |   94 ++++++++++++---------------------------------
>  sbc/sbc_primitives.c      |   75 ++++++++++++++++++++++++++++++++++++
>  sbc/sbc_primitives.h      |    4 ++
>  sbc/sbc_primitives_mmx.c  |   54 ++++++++++++++++++++++++++
>  sbc/sbc_primitives_neon.c |   58 +++++++++++++++++++++++++++
>  5 files changed, 216 insertions(+), 69 deletions(-)

All three patches have been pushed upstream. Thanks!

Johan

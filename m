Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 15:07:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] sbc: added "cc" to the clobber list of mmx inline
 assembly
Message-ID: <20101111130730.GA14724@jh-x301>
References: <1289467782-2472-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289467782-2472-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Thu, Nov 11, 2010, Siarhei Siamashka wrote:
> In the case of scale factors calculation optimizations, the inline
> assembly code has instructions which update flags register, but
> "cc" was not mentioned in the clobber list. When optimizing code,
> gcc theoretically is allowed to do a comparison before the inline
> assembly block, and a conditional branch after it which would lead
> to a problem if the flags register gets clobbered. While this is
> apparently not happening in practice with the current versions of
> gcc, the clobber list needs to be corrected.
> 
> Regarding the other inline assembly blocks. While most likely it
> is actually unnecessary based on quick review, "cc" is also added
> there to the clobber list because it should have no impact on
> performance in practice. It's kind of cargo cult, but relieves
> us from the need to track the potential updates of flags register
> in all these places.
> ---
>  sbc/sbc_primitives_mmx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Thanks for the patch! It has now been pushed upstream.

Johan

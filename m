Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Oct 2011 11:21:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump 2/2] decode fixed channel list info rsp
Message-ID: <20111025092139.GC3514@fusion.localdomain>
References: <1319448154-8743-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1319448154-8743-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319448154-8743-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Oct 24, 2011, Emeltchenko Andrei wrote:
> Decode fixed channels in information response
> 
> < ACL data: handle 1 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 3
> > ACL data: handle 1 flags 0x02 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list 0x0000000a
>         L2CAP Signalling Channel
>         AMP Manager Protocol
> ---
>  parser/l2cap.c |   23 ++++++++++++++++++++---
>  1 files changed, 20 insertions(+), 3 deletions(-)

Both patches have been applied, but I had to fix the following to use
PRIx64 instead of %llx to compile both on 32 and 64 bit architectures.

> +		printf("Fixed channel list 0x%8.8llx\n", fc_mask);

Johan

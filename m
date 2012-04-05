Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:30:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 1/4] Add Bluetooth address type in sockaddr_l2
Message-ID: <20120405103011.GF32212@x220>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Apr 04, 2012, Claudio Takahasi wrote:
> This patch adds the address type information to sockaddr_l2 structure,
> allowing the userspace to inform the remote address type required for
> LE Create Connection command.
> ---
>  lib/l2cap.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/l2cap.h b/lib/l2cap.h
> index 5806aaa..5ce94c4 100644
> --- a/lib/l2cap.h
> +++ b/lib/l2cap.h
> @@ -43,6 +43,7 @@ struct sockaddr_l2 {
>  	unsigned short	l2_psm;
>  	bdaddr_t	l2_bdaddr;
>  	unsigned short	l2_cid;
> +	uint8_t		l2_bdaddr_type;
>  };
>  
>  /* L2CAP socket options */

To answer my question about what defines/enum values are passed to the
BtIO API, this patch should probably be adding the same BDADDR_* defines
that Andre's patch 2/5 is adding on the kernel side, and then your BtIO
patch should use BDADDR_BREDR to initialize opts->dst_type.

Johan

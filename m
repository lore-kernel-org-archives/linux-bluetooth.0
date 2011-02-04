Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Feb 2011 06:54:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix parameter type in att_put_u32
Message-ID: <20110204045419.GA1551@jh-x301>
References: <1296740222-27174-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1296740222-27174-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Feb 03, 2011, Elvis Pfützenreuter wrote:
> ---
>  attrib/att.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/attrib/att.h b/attrib/att.h
> index 1caa62a..7e81dc4 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -180,7 +180,7 @@ static inline void att_put_u16(uint16_t src, void *dst)
>  	bt_put_unaligned(htobs(src), (uint16_t *) dst);
>  }
>  
> -static inline void att_put_u32(uint16_t src, void *dst)
> +static inline void att_put_u32(uint32_t src, void *dst)
>  {
>  	bt_put_unaligned(htobl(src), (uint32_t *) dst);
>  }

Pushed upstream. Thanks.

Johan

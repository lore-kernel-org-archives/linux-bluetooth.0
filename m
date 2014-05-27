Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] attrib: Fix minor whitespace issue
Date: Tue, 27 May 2014 22:56:15 +0200
Message-ID: <1702302.G5WLWg8oyY@leonov>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 27 of May 2014 12:15:29 Jakub Tyszkowski wrote:
> Replace spaces with tabs.
> ---
>  attrib/att.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/attrib/att.h b/attrib/att.h
> index 068ddf8..c92cd5d 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -86,8 +86,8 @@
>  #define ATT_PSM					31
> 
>  /* Flags for Execute Write Request Operation */
> -#define ATT_CANCEL_ALL_PREP_WRITES              0x00
> -#define ATT_WRITE_ALL_PREP_WRITES               0x01
> +#define ATT_CANCEL_ALL_PREP_WRITES		0x00
> +#define ATT_WRITE_ALL_PREP_WRITES		0x01
> 
>  /* Find Information Response Formats */
>  #define ATT_FIND_INFO_RESP_FMT_16BIT		0x01

Patches 1-4 are now applied, thanks.

-- 
BR
Szymon Janc

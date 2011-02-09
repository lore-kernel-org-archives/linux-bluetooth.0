Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 14:04:26 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] use a valid PSM value in l2test.
Message-ID: <20110209220426.GF11911@jh-x301>
References: <1297276920-15467-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297276920-15467-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Feb 09, 2011, Gustavo F. Padovan wrote:
> ---
>  test/l2test.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/test/l2test.c b/test/l2test.c
> index 17883a9..3ac332f 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -87,7 +87,7 @@ static long buffer_size = 2048;
>  
>  /* Default addr and psm and cid */
>  static bdaddr_t bdaddr;
> -static unsigned short psm = 10;
> +static unsigned short psm = 0x1011;
>  static unsigned short cid = 0;
>  
>  /* Default number of frames to send (-1 = infinite) */

Pushed upstream. Thanks.

Johan

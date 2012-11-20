Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 15:52:13 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2 v1] l2test: Add support to test auto select PSM
Message-ID: <20121120175213.GH14006@joana>
References: <1353428151-11925-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353428151-11925-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-11-20 21:45:51 +0530]:

> This patch enable us to test the auto select PSM for server by passing
> PSM value as 0.
> 
> Ex: l2test -d -P 0
> l2test[2585]: Waiting for connection on psm 4097 ...
> ---
> v1-> Corrected the misplaced code
> 
>  test/l2test.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/test/l2test.c b/test/l2test.c
> index 7645681..485887f 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -87,7 +87,7 @@ static long buffer_size = 2048;
>  
>  /* Default addr and psm and cid */
>  static bdaddr_t bdaddr;
> -static unsigned short psm = 0x1011;
> +static unsigned short psm = 0;

Your patch makes the client side to always pass the psm option and I don't
think this is a good approach. I think we need something smarter here to not
break things.

	Gustavo

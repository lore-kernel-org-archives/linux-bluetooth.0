Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Nov 2012 10:05:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] l2test: Add support to test auto select PSM
Message-ID: <20121116080528.GA9653@x220>
References: <1352449889-5149-1-git-send-email-s.syam@samsung.com>
 <1352449889-5149-2-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352449889-5149-2-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Fri, Nov 09, 2012, Syam Sidhardhan wrote:
> This patch enable us to test the auto select PSM by passing
> PSM value as 0.
> 
> Ex: l2test -d -P 0
> l2test[2585]: Waiting for connection on psm 4099 ...
> ---
>  test/l2test.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/test/l2test.c b/test/l2test.c
> index 7645681..72ad4ba 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -87,7 +87,7 @@ static long buffer_size = 2048;
>  
>  /* Default addr and psm and cid */
>  static bdaddr_t bdaddr;
> -static unsigned short psm = 0x1011;
> +static unsigned short psm = 0;
>  static unsigned short cid = 0;
>  
>  /* Default number of frames to send (-1 = infinite) */
> @@ -375,8 +375,6 @@ static int do_connect(char *svr)
>  		addr.l2_cid = htobs(cid);
>  	else if (psm)
>  		addr.l2_psm = htobs(psm);
> -	else
> -		goto error;
>  
>  	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0 ) {
>  		syslog(LOG_ERR, "Can't connect: %s (%d)",

At least the second chunk is for the initiating (client) part, not the
server (which the commit message implies you're dealing with). There's
no "auto select" for the client.

Johan

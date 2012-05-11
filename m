Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 May 2012 20:13:19 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] monitor: add device filter support
Message-ID: <20120511231318.GB9909@samus>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336753132-8282-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 13:18 Fri 11 May, Gustavo Padovan wrote:
> -i hciX option will show only data from the specified device
> ---
>  monitor/main.c   |   12 ++++++++++--
>  monitor/packet.c |   10 +++++++++-
>  monitor/packet.h |    2 +-
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index 90e32c5..99b53e9 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -28,6 +28,7 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <getopt.h>
>  
>  #include "mainloop.h"
> @@ -52,12 +53,14 @@ static void usage(void)
>  		"Usage:\n");
>  	printf("\tbtmon [options]\n");
>  	printf("options:\n"
> +		"\t-i dev                HCI device\n"
>  		"\t-b, --btsnoop <file>  Save dump in btsnoop format\n"
>  		"\t-h, --help            Show help options\n");
>  }
>  
>  static const struct option main_options[] = {
>  	{ "btsnoop",	required_argument, NULL, 'b'	},
> +	{ "",		required_argument, NULL, 'i'	},

btmgmt is calling this "index", how about using the same long name for
consistency?

[snip]


Cheers,
-- 
Vinicius

Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Aug 2010 14:22:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix using wrong argument in test-serial
Message-ID: <20100816112252.GA14417@jh-x301>
References: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 16, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> ---
>  test/test-serial |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/test/test-serial b/test/test-serial
> index ed151dc..cc496df 100755
> --- a/test/test-serial
> +++ b/test/test-serial
> @@ -29,7 +29,7 @@ if (len(args) < 1):
>  	print "Usage: %s <address> [service]" % (sys.argv[0])
>  	sys.exit(1)
>  
> -address = sys.argv[0]
> +address = args[0]
>  
>  if (len(args) < 2):
>  	service = "spp"

The patch is now upstream. Thanks.

Johan

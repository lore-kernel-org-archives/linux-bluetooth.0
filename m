Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] log: Add function to get/set debug_string
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
References: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 15:31:35 +0200
Message-ID: <1276695095.2301.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>  src/log.c |   53 +++++++++++++++++++++++++++++++++++++++++------------
>  src/log.h |    2 ++
>  2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/src/log.c b/src/log.c
> index ed6e428..f53ace3 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -71,6 +71,8 @@ extern struct btd_debug_desc __stop___debug[];
>  
>  static gchar **enabled = NULL;
>  
> +static char *debug_string = NULL;
> +

can you please stop messing around with this so much. This looks all so
heavily complicated and convoluted. The log.c is not storing the current
debug command line parameter. It doesn't care about that. So why should
it bother.

Just have a function __btd_enable_debug(const char *debug) and make that
work. You can even use that one from the SIGUSR2 with just "*" as
parameter.

If the D-Bus API wants to present a read-able value of what is the
current string, then that is up to the D-Bus manager object and not the
logging code.

Right now I am actually inclined to just say we don't bother with
changing debug options via D-Bus at all. So I want a simple and clean
patch or we should just not do it at all.

Regards

Marcel



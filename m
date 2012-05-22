Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 12:02:39 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 3/4] monitor: add filter support
Message-ID: <20120522150239.GA12709@samus>
References: <1337665227-7228-1-git-send-email-gustavo@padovan.org>
 <1337665227-7228-2-git-send-email-gustavo@padovan.org>
 <1337665227-7228-3-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337665227-7228-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Here are some nitpicks, feel free to ignore them.

On 02:40 Tue 22 May, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The title "add filter support" is not totally correct, there was some
support for filters, but it was quite basic, right?

> 
> the packet code receives the data parsed from the filter file and apply
> the proper filters to the devices.
> ---
>  monitor/config_file.c |    4 +-
>  monitor/config_file.h |    1 +
>  monitor/main.c        |   21 +++++-----
>  monitor/packet.c      |  108 ++++++++++++++++++++++++++++++++++++++++---------
>  monitor/packet.h      |    4 +-
>  5 files changed, 106 insertions(+), 32 deletions(-)
> 
> diff --git a/monitor/config_file.c b/monitor/config_file.c
> index 6fb50f9..464fe4f 100644
> --- a/monitor/config_file.c
> +++ b/monitor/config_file.c
> @@ -79,7 +79,7 @@ static struct filter_options {
>  
>  struct controller *controller;
>  
> -static void free_controllers_list(struct list *controllers_l)
> +void controllers_list_free(struct list *controllers_l)

This change is somewhat unrelated.

>  {
>  	struct list *l, *tmp;
>  
> @@ -318,7 +318,7 @@ struct list *parse_config(char *file)
>  	return controllers_l;
>  
>  error:


[snip]

>  
>  void packet_hexdump(const unsigned char *buf, uint16_t len);
>  
> -- 
> 1.7.10.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

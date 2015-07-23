Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Jul 2015 09:48:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Subject: Re: [RFC v2 3/4] 6lowpan: Add stateful compression support for iphc.c
Message-ID: <20150723074835.GA18161@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
 <1436788233-13960-4-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1436788233-13960-4-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 13, 2015 at 01:50:32PM +0200, Lukasz Duda wrote:
...
>  		} else {
>  			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
>  			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
> @@ -619,6 +774,9 @@ static int __init lowpan_module_init(void)
>  {
>  	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
>  
> +	/* Initialize stateful compression. */
> +	lowpan_context_init();
> +

Error handling here, too. You need to change lowpan_context_init for
returning return value from debugfs_create_file then.

The rest will I review when I get it running. :-)

- Alex

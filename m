Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Sep 2014 09:51:55 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: gowtham babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com,
	cpgs@samsung.com
Subject: Re: [PATCH 1/2] tools/btsnoop : Fix variable reassigning issue
Message-ID: <20140912165155.GB3671@t440s>
References: <1410330944-3492-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410330944-3492-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 10, 2014, gowtham babu wrote:
> The Variable 'written' is reassigned a value before the old one has been used.
> The below on fix the same.
> ---
>  tools/btsnoop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/btsnoop.c b/tools/btsnoop.c
> index 6ca62d2..86f4691 100644
> --- a/tools/btsnoop.c
> +++ b/tools/btsnoop.c
> @@ -211,7 +211,7 @@ next_packet:
>  		goto next_packet;
>  	}
>  
> -	written = input_pkt[select_input].size = htobe32(toread - 1);
> +	input_pkt[select_input].size = htobe32(toread - 1);
>  	written = input_pkt[select_input].len = htobe32(toread - 1);

Why is there a need to evaluate htobe32(toread - 1) twice here? Why not
avoid that by something like:

	written = htobe32(toread - 1);
	input_pkt[select_input].size = written;
	input_pkt[select_input].len  = written;

Johan

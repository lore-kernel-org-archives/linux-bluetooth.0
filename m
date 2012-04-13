Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:11:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Temporary keys should be retained during
 connection
Message-ID: <20120413091152.GA10608@x220.ger.corp.intel.com>
References: <1334307675-2983-1-git-send-email-vishal.agarwal@stericsson.com>
 <1334307675-2983-2-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334307675-2983-2-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Fri, Apr 13, 2012, Vishal Agarwal wrote:
> If a key is non persistent then it should not be used in future
> connections but it should be kept for current connection. And it
> should be removed when connecion is removed.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    8 ++++----
>  net/bluetooth/hci_event.c        |    2 ++
>  3 files changed, 7 insertions(+), 4 deletions(-)

In general the patch looks good but I'd simplify/shorten the following
just a tiny bit:

> -	if (!persistent) {
> -		list_del(&key->list);
> -		kfree(key);
> -	}
> +	if (!conn)
> +		return 0;
> +
> +	conn->flush_key = !persistent;
>  
>  	return 0;

Instead you could just do:

	if (conn)
		conn->flush_key = !persistent;

	return 0;

Johan

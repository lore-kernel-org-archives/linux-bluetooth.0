Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:15:31 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2 1/4] Bluetooth: Rename cmd to cmd_params in pending_cmd
Message-ID: <20110317181531.GB2214@joana>
References: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
 <1299000216-6570-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299000216-6570-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-03-01 18:23:33 +0100]:

> This field holds not whole command but only command specific
> parameters.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e6efaae..bde42a5 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -36,7 +36,7 @@ struct pending_cmd {
>  	struct list_head list;
>  	__u16 opcode;
>  	int index;
> -	void *cmd;
> +	void *cmd_params;

I prefer 'param' then.

-- 
Gustavo F. Padovan
http://profusion.mobi

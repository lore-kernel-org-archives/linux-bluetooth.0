Return-Path: <cyrus@holtmann.org>
Message-ID: <4EF41FA5.1030903@codeaurora.org>
Date: Thu, 22 Dec 2011 22:28:53 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Hemant Gupta <hemant.gupta@stericsson.com>
CC: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH-v1 1/1] Bluetooth: Incorrect address while storing LTK.
References: <1324618644-17551-1-git-send-email-hemant.gupta@stericsson.com> <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
In-Reply-To: <1324618644-17551-2-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On 12/22/2011 9:37 PM, Hemant Gupta wrote:
> This patch fixes incorrect address storage while storing
> Long Term Key for LE Devices using SMP (Security Manager Protocol).
> The address stored should be of remote device and not of source device.
>
> Signed-off-by: Hemant Gupta<hemant.gupta@stericsson.com>
> ---
>   net/bluetooth/smp.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 9fea4bf..32c47de 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -820,7 +820,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
>
>   	skb_pull(skb, sizeof(*rp));
>
> -	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
> +	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
>   						rp->ediv, rp->rand, smp->tk);
>
>   	smp_distribute_keys(conn, 1);

I agree that this is a bug, and that this is the correct fix.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

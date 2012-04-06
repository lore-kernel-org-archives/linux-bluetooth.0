Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 20:23:43 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 10/26] Bluetooth: A2MP: Process A2MP Command Reject
Message-ID: <20120406232343.GG2915@joana>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332941509-21345-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-28 16:31:33 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Placeholder for future A2MP Command Reject handler.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 25d505e..745ab0c 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -65,6 +65,22 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
>  	kfree(cmd);
>  }
>  
> +/* Processing A2MP messages */
> +static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
> +				   struct a2mp_cmd *hdr)

Remove the inline, let the compiler choose it for you.

> +{
> +	struct a2mp_cmd_rej *rej = (struct a2mp_cmd_rej *) skb->data;
> +
> +	if (le16_to_cpu(hdr->len) < sizeof(*rej))

Isn't != better here, if I understood correctly this has a fixed size.

	Gustavo

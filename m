Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 15:49:46 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH 04/10] Bluetooth: Use EIO code to report HCI error to
 userpace
Message-ID: <20110217134946.GY874@null>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
 <1297948601-12723-5-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297948601-12723-5-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 17, 2011 at 02:16:35PM +0100, ext Szymon Janc wrote:
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

Some kind of explanation why EIO is better than status would be nice.


> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index aee1da6..dee82fe 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1372,8 +1372,7 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
>  		return -ENOENT;
>  
>  	if (status != 0)
> -		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, status, NULL,
> -									0);
> +		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, EIO, NULL, 0);
>  	else
>  		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY,
>  						bdaddr, sizeof(*bdaddr));
> @@ -1394,8 +1393,8 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
>  		return -ENOENT;
>  
>  	if (status != 0)
> -		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, status,
> -								NULL, 0);
> +		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, EIO, NULL,
> +									0);
>  	else
>  		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
>  						bdaddr, sizeof(*bdaddr));

-- 
Ville

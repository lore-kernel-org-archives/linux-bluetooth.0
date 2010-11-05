Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 16:01:58 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 7/7] Bluetooth: Fix not returning proper error in RFCOMM
Message-ID: <20101105140158.GE19903@null>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-2-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-3-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-4-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-5-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-6-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-7-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288710198-6108-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Nov 02, 2010 at 04:03:18PM +0100, ext Gustavo F. Padovan wrote:
> Return 0 in that situation could lead to errors in the caller.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index e48fbca..cd7e27a 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -930,7 +930,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
>  	/* Check if we have socket listening on channel */
>  	parent = rfcomm_get_sock_by_channel(BT_LISTEN, channel, &src);
>  	if (!parent)
> -		return 0;
> +		return -EINVAL;

Did you check rfcomm/core.c?

I think this change breaks the logic in there. IOW continues connection
establisment instead of tearing down the link.

-- 
Ville

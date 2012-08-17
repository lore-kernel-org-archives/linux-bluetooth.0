Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Aug 2012 10:39:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: Re: [PATCH BlueZ v3 13/14] core: Disable unnecessary auto connections
Message-ID: <20120817073911.GA30060@x220>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
 <1345152524-13404-14-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345152524-13404-14-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 16, 2012, João Paulo Rechi Vita wrote:
> BlueZ host disconnects the link when encryption fails. ECONNABORTED
> error is returned by the kernel when the connection is terminated by the
> local host. This scenario commonly happens when authentication fails due
> PIN or Key Missing.
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/device.c b/src/device.c
> index 645a2b7..5490e37 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1956,6 +1956,9 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
>  	struct att_callbacks *attcb = user_data;
>  	struct btd_device *device = attcb->user_data;
>  
> +	if (gerr->code == ECONNABORTED)
> +		return;
> +

I think it'd be more appropriate to use g_error_matches() here.

Johan

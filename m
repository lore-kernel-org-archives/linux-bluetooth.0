Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 14:40:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Fix avrcp unregister potential crash
Message-ID: <20120518114032.GB1375@x220.P-661HNU-F1>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
 <1337331254-30749-2-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337331254-30749-2-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Fri, May 18, 2012, chanyeol.park@samsung.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> ---
>  audio/avrcp.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index df39d04..2e946c1 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1272,8 +1272,11 @@ void avrcp_unregister(const bdaddr_t *src)
>  
>  	servers = g_slist_remove(servers, server);
>  
> -	remove_record_from_server(server->ct_record_id);
> -	remove_record_from_server(server->tg_record_id);
> +	if (server->ct_record_id)
> +		remove_record_from_server(server->ct_record_id);
> +
> +	if (server->tg_record_id)
> +		remove_record_from_server(server->tg_record_id);
>  
>  	avctp_unregister(&server->src);
>  	g_free(server);

I don't think the commit message for this patch is truthful. If you look
at the code the remove_record_from_server will return ENOENT if you pass
it a non-existent handle. I.e. it will not crash. Please fix the commit
message to reflect what exactly is being fixed (i.e. an unnecessary call
to remove_record_from_server if there is no record handle).

Johan

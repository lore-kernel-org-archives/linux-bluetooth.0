Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 13:17:14 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avrcp: Fix buffer size
Message-ID: <20140228111712.GC6861@aemeltch-mobl1.fi.intel.com>
References: <1393584252-10947-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393584252-10947-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 28, 2014 at 12:44:12PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For avrcp_get_current_player_value() buffer size needs to be
> AVRCP_ATTRIBUTE_LAST + 1 for all attributes + 1 for number of attributes
> written first, not counting header.

Sorry, please disregard this, attribute 0 should not be used.

> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index c0e5d07..8098c62 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1905,7 +1905,7 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
>  static void avrcp_get_current_player_value(struct avrcp *session,
>  						uint8_t *attrs, uint8_t count)
>  {
> -	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_ATTRIBUTE_LAST + 1];
> +	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_ATTRIBUTE_LAST + 2];
>  	struct avrcp_header *pdu = (void *) buf;
>  	uint16_t length = AVRCP_HEADER_LENGTH + count + 1;
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

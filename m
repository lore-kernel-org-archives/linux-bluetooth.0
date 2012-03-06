Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Mar 2012 14:54:56 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	lucas.demarchi@profusion.mobi
Subject: Re: [PATCH v2 2/2] avrcp: Add error code for rejected vendor command
Message-ID: <20120306225456.GA14144@x220.amr.corp.intel.com>
References: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA%40mail.gmail.com>
 <1331045765-24790-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331045765-24790-1-git-send-email-michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Mar 06, 2012, Michal Labedzki wrote:
> diff --git a/audio/avctp.h b/audio/avctp.h
> index 9727485..a1109a9 100644
> --- a/audio/avctp.h
> +++ b/audio/avctp.h
> @@ -97,3 +97,8 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op);
>  int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
>  				uint8_t code, uint8_t subunit,
>  				uint8_t *operands, size_t operand_count);
> +
> +size_t handle_vendor_reject(struct avctp *session, uint8_t transaction,
> +					uint8_t *code, uint8_t *subunit,
> +					uint8_t *operands, size_t operand_count,
> +					void *user_data);

You should follow the existing name-spacing of the .h file. Actually
this shouldn't be in avctp.h at all since the implementation is in
avrcp.c. So move to avrcp.h and add the appropriate prefix.

> \ No newline at end of file

Please fix the above.

> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 4573133..2d29d56 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -862,6 +862,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>  	position = player->cb->get_position(player->user_data);
>  	pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
>  							player->user_data);
> +
>  	if (pduration != NULL)
>  		duration = htonl(GPOINTER_TO_UINT(pduration));
>  	else

The above addition seems completely unrelated to the rest of the patch.
Please remove it.

Johan

Return-Path: <cyrus@holtmann.org>
Message-id: <50FD567C.1000209@samsung.com>
Date: Mon, 21 Jan 2013 23:53:48 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	SYAM SIDHARDHAN <s.syam@samsung.com>
Subject: Re: [PATCH BlueZ 5/9 v3] audio: Fix handling of A2DP abort indication
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
 <1339771301-24032-5-git-send-email-luiz.dentz@gmail.com>
In-reply-to: <1339771301-24032-5-git-send-email-luiz.dentz@gmail.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz.

Regarding your patch that was applied already, I think
finalize_setup_errno() function missed NULL argument.

This is reported by Syam Sidhardhan <s.syam@samsung.com>

On 06/15/2012 11:41 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When an abort is received all setup callbacks should return an error.
> ---
>   audio/a2dp.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index 5139f61..d9dcead 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1182,6 +1182,7 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>   				void *user_data)
>   {
>   	struct a2dp_sep *a2dp_sep = user_data;
> +	struct a2dp_setup *setup;
>   
>   	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
>   		DBG("Sink %p: Abort_Ind", sep);
> @@ -1190,6 +1191,14 @@ static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>   
>   	a2dp_sep->stream = NULL;
>   
> +	setup = find_setup_by_session(session);
> +	if (!setup)
> +		return TRUE;
> +
> +	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
> +							finalize_resume,
> +							finalize_config);
> +
Here.

Could you give us your opinion?

Regards
Chanyeol


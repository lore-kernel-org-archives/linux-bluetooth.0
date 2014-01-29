Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390939534-15699-1-git-send-email-luiz.dentz@gmail.com>
References: <1390939534-15699-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 29 Jan 2014 09:07:45 -0800
Message-ID: <CABBYNZ+qhc-i_h5T+uzfDD6jnfFTZbFNSjXbinbhJUSWLm5_Ug@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/AVRCP: Fix sending invalid response to GetCapabilities
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 28, 2014 at 12:05 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The attribute count has to be initialized with 0 since we reuse the same
> buffer for both command and responses it may be already be set causing
> invalid response to be generated.
> ---
>  profiles/audio/avrcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 59a966e..ad5dc34 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -921,6 +921,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>
>                 return AVC_CTYPE_STABLE;
>         case CAP_EVENTS_SUPPORTED:
> +               pdu->params[1] = 0;
>                 for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
>                         if (session->supported_events & (1 << i)) {
>                                 pdu->params[1]++;
> --
> 1.8.4.2

Applied.


-- 
Luiz Augusto von Dentz

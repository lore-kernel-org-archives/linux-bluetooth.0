Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312568132-21112-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1312568132-21112-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 11:41:49 +0300
Message-ID: <CABBYNZ+amA0pcN0jEdE_dT4r-bcBJ59SgG1vqdZPneAoy8xeHg@mail.gmail.com>
Subject: Re: [PATCH 02/23] avrcp: use C99 instead of gcc extension
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Aug 5, 2011 at 9:15 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/control.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/audio/control.c b/audio/control.c
> index c3ef737..1ec736f 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -134,7 +134,7 @@ struct avrcp_spec_avc_pdu {
>        uint8_t packet_type:2;
>        uint8_t rsvd:6;
>        uint16_t params_len;
> -       uint8_t params[0];
> +       uint8_t params[];
>  } __attribute__ ((packed));
>  #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
>
> @@ -164,7 +164,7 @@ struct avrcp_spec_avc_pdu {
>        uint8_t rsvd:6;
>        uint8_t packet_type:2;
>        uint16_t params_len;
> -       uint8_t params[0];
> +       uint8_t params[];
>  } __attribute__ ((packed));
>  #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7

Not sure if this is really necessary, there several places where we do
that and we normally use __attribute__((packed)) is we still depend on
gcc extension in one way or the other.

-- 
Luiz Augusto von Dentz

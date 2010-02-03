Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265225690-48832-1-git-send-email-npelly@google.com>
References: <1265225690-48832-1-git-send-email-npelly@google.com>
From: Nick Pelly <npelly@google.com>
Date: Wed, 3 Feb 2010 11:44:49 -0800
Message-ID: <35c90d961002031144u47d26cf8q1df0a8390de139d5@mail.gmail.com>
Subject: Re: [PATCH] Add 0xff (any object type) to sdptool OPUSH supported
	formats list.
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 3, 2010 at 11:34 AM, Nick Pelly <npelly@google.com> wrote:
> This fixed an issue with sending an image from OSX. OSX would show a warning
> that the bluez stack does not support this file type, but offer to send it
> anyway (which works). This change to advertise support for all object types
> will remove this warning.
>
> The list of file types that can be advertised in the SDP record is very limited
> anyway. It is best to list that we support all file types here, and then filter
> at the OPP/OBEX connection instead.
>
> For reference:
> 0x01 = vCard 2.1
> 0x02 = vCard 3.0
> 0x03 = vCal 1.0
> 0x04 = iCal 2.0
> 0x05 = vNote
> 0x06 = vMessage
> 0xFF = any type of object.
> ---
>  tools/sdptool.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index 5a199a9..89166ae 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -1751,8 +1751,7 @@ static int add_opush(sdp_session_t *session, svc_info_t *si)
>        sdp_record_t record;
>        uint8_t chan = si->channel ? si->channel : 9;
>        sdp_data_t *channel;
> -       uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06 };
> -       //uint8_t formats[] = { 0xff };
> +       uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xff };
>        void *dtds[sizeof(formats)], *values[sizeof(formats)];
>        unsigned int i;
>        uint8_t dtd = SDP_UINT8;
> --
> 1.6.5.3

(Patch updated to include 0x01...0x06 as well as 0xff - based on
feedback from Marcel that removing 0x01...0x06 from the list could
actually confuse some OPP devices)

Nick

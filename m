Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334786904-26282-9-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-9-git-send-email-jprvita@openbossa.org>
Date: Fri, 20 Apr 2012 15:23:54 -0400
Message-ID: <CAJdJm_OFG4JSxrHzLY9X7uG34U-N8bD7=Rb=ZXq-t779mCc-Mw@mail.gmail.com>
Subject: Re: [RFC v2 08/16] HoG: add report notification handler
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
> ---
>  input/hog_device.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/input/hog_device.c b/input/hog_device.c
> index ac6d4c9..5df6879 100644
> --- a/input/hog_device.c
> +++ b/input/hog_device.c
> @@ -71,9 +71,27 @@ static void report_free(struct report *report)
>        g_free(report);
>  }
>
> +static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
> +{
> +       uint16_t handle;
> +
> +       if (len < 3) {

I suppose the check should be (len < 10) here ? Otherwise the DBG()
call will read invalid data.

> +               error("Malformed ATT notification");
> +               return;
> +       }
> +
> +       handle = att_get_u16(&pdu[1]);
> +
> +       DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
> +                               "0x%02x", handle, pdu[2], pdu[3], pdu[4],
> +                               pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);

This DBG() seems strange. If handle starts at (pdu + 1) and has two
octets, the remaining bytes should start at (pdu + 3).

> +}
> +

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

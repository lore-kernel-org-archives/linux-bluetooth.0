Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309777369-21475-1-git-send-email-szymon.janc@tieto.com>
References: <1309777369-21475-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 4 Jul 2011 08:20:08 -0400
Message-ID: <CAJdJm_MgPgniRrnExvWoavJTZObDzDUJSUno5z-DoqEaV8+t1w@mail.gmail.com>
Subject: Re: [PATCH] Add SAP driver for ST-Ericsson U8500 platform
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jul 4, 2011 at 7:02 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> +       gstatus = g_io_channel_read_chars(io, buf, sizeof(buf), &bytes_read,
> +                                                                       &gerr);
> +       if (gstatus != G_IO_STATUS_NORMAL) {
> +               if (gerr)
> +                       g_error_free(gerr);
> +
> +               sap_error("error while reading from channel (%d)", gstatus);
> +               return TRUE;
> +       }

You can pass NULL to the last argument of g_io_channel_read_chars() if
you are not using the gerr (as in the case above).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

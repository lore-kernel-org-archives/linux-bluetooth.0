Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305178350-7568-2-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
	<1305178350-7568-2-git-send-email-padovan@profusion.mobi>
Date: Thu, 12 May 2011 14:16:20 -0400
Message-ID: <BANLkTimv_yX_abp-3hutps5EZ1+HXQEoKw@mail.gmail.com>
Subject: Re: [PATCH 2/6] Bluetooth: Create l2cap_chan_send()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 12, 2011 at 1:32 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> +               } else {
> +               /* Segment SDU into multiples PDUs */

Given that you are moving code around, can you fix the indentation
error on the comment above?

> +                       err = l2cap_sar_segment_sdu(chan, msg, len);
> +                       if (err < 0)
> +                               return err;
> +               }
> +
> +               if (chan->mode == L2CAP_MODE_STREAMING) {
> +                       l2cap_streaming_send(chan);
> +                       err = len;
> +                       break;
> +               }
> +
> +               if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
> +                               (chan->conn_state & L2CAP_CONN_WAIT_F)) {
> +                       err = len;
> +                       break;
> +               }
> +               err = l2cap_ertm_send(chan);
> +
> +               if (err >= 0)
> +                       err = len;
> +               break;

Also, it makes more sense to have an empty line above
l2cap_ertm_send(), and remove the empty line below it.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

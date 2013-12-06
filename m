Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386249090-10236-31-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
	<1386249090-10236-31-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 5 Dec 2013 20:02:04 -0400
Message-ID: <CAJdJm_Pvc97a8i3vcO4NO0sDJFzUyJ3JOkGuwOyYL8Bi8RjE5A@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] Bluetooth: Fix validating LE PSM values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Dec 5, 2013 at 9:11 AM,  <johan.hedberg@gmail.com> wrote:
> +static bool is_valid_psm(u16 psm, u8 dst_type)
> +{
> +       if (!psm)
> +               return false;
> +
> +       if (bdaddr_type_is_le(dst_type))
> +               return (psm < 0x00ff);

Shouldn't be "psm <= 0x00ff" here?

> +
> +       /* PSM must be odd and lsb of upper byte must be 0 */
> +       return ((psm & 0x0101) == 0x0001);
> +}
> +
>  int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>                        bdaddr_t *dst, u8 dst_type)
>  {

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

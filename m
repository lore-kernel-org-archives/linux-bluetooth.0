Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305178350-7568-3-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
	<1305178350-7568-2-git-send-email-padovan@profusion.mobi>
	<1305178350-7568-3-git-send-email-padovan@profusion.mobi>
Date: Thu, 12 May 2011 13:58:34 -0400
Message-ID: <BANLkTimQ_AC0X1XZAbwmPh2q+iXKT2c05A@mail.gmail.com>
Subject: Re: [PATCH 3/6] Bluetooth: Add chan->link_type struct member
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 12, 2011 at 1:32 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -204,8 +204,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>        }
>
>        /* PSM must be odd and lsb of upper byte must be 0 */
> -       if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
> -                               sk->sk_type != SOCK_RAW && !la.l2_cid) {
> +       if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 && !la.l2_cid &&
> +                                       chan->link_type == L2CAP_LINK_RAW) {

There seems to be a typo here:

Original: sk->sk_type != SOCK_RAW
New: chan->link_type == L2CAP_LINK_RAW

Should it be != instead?

>                err = -EINVAL;
>                goto done;
>        }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

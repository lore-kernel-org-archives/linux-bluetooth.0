Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
	<1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Nov 2010 11:38:22 -0400
Message-ID: <AANLkTimFz=FRPiGT31xt9wMjWoxC5cuKBubEqYNT0s=5@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management interface callbacks
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Nov 24, 2010 at 10:39 AM,  <johan.hedberg@gmail.com> wrote:
>  static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>  {
> -       struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
> +       struct sockaddr_hci haddr;

Just out of curiosity: why is this change necessary (i.e. make a stack
copy of addr data and use it instead of using a cast of addr)?

>        struct sock *sk = sock->sk;
>        struct hci_dev *hdev = NULL;
> -       int err = 0;
> +       int len, err = 0;
>
>        BT_DBG("sock %p sk %p", sock, sk);
>
> -       if (!haddr || haddr->hci_family != AF_BLUETOOTH)
> +       if (!addr)
> +               return -EINVAL;
> +
> +       memset(&haddr, 0, sizeof(haddr));
> +       len = min_t(unsigned int, sizeof(haddr), addr_len);
> +       memcpy(&haddr, addr, len);

Looks like you are playing safe here, but looking at least a few
->bind() implementations I see most just cast the original struct
sockaddr, which is has size (sizeof(unsigned short) + 14).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

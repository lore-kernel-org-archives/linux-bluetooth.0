Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286390535-27462-6-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
	<1286390535-27462-6-git-send-email-ville.tervo@nokia.com>
Date: Wed, 6 Oct 2010 16:14:00 -0400
Message-ID: <AANLkTim2p40Z55agDoLFtNY-nzXPrqkUACjFHR_c2oYz@mail.gmail.com>
Subject: Re: [PATCH 5/7] Bluetooth: Add LE connection support to L2CAP
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 6, 2010 at 2:42 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> @@ -1014,13 +1029,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>        len = min_t(unsigned int, sizeof(la), alen);
>        memcpy(&la, addr, len);
>
> -       if (la.l2_cid)
> ++      if (la.l2_cid && la.l2_psm)
>                return -EINVAL;
>
>        lock_sock(sk);
>
>        if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
> -                       && !la.l2_psm) {
> +                       && !(la.l2_psm || la.la_cid)) {
>                err = -EINVAL;
>                goto done;
>        }

This snippet looks strange for two reasons:

1) the "++" marker looks weird. Corrupted patch?
2) there is a typo here : la.la_cid -> la.l2_cid . Didn't the compiler
catch this?

Note that there are some other occurrences of "++" in this patch.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

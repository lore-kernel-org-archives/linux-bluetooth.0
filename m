Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-2-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-3-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-4-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-5-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-6-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-7-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-8-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-9-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-10-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-11-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-12-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-13-git-send-email-padovan@profusion.mobi>
Date: Mon, 4 Apr 2011 17:00:17 -0400
Message-ID: <BANLkTikP-bL5LUmmim7Y3dxrsU7Qwuhm0Q@mail.gmail.com>
Subject: Re: [PATCH 12/15] Bluetooth: Move ERTM timers to struct l2cap_chan
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -958,7 +961,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
>
>        bh_lock_sock(sk);
>        if (chan->retry_count >= chan->remote_max_tx) {
> -               l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
> +               l2cap_send_disconn_req(l2cap_pi(chan)->conn, chan, ECONNABORTED);
>                bh_unlock_sock(sk);
>                return;
>        }

Why "l2cap_pi(chan)" ? This looks strange.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:37:32 -0200
Message-ID: <CAA37ikbScY7dz6iP9FL5-x1SiNWfNOKvsQ77U1VrvmMJFGDWFg@mail.gmail.com>
Subject: Re: [PATCHv1 14/14] Bluetooth: Remove socket lock check
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 8:55 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Simplify code so that we do not need to check whether socket is locked.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index bbc1747..e2fc24b 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -125,15 +125,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>
>        err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
>        if (err)
> -               goto done;
> +               return err;
>
>        lock_sock(sk);
>
>        err = bt_sock_wait_state(sk, BT_CONNECTED,
>                        sock_sndtimeo(sk, flags & O_NONBLOCK));
> -done:
> -       if (sock_owned_by_user(sk))
> -               release_sock(sk);
> +
> +       release_sock(sk);
> +
>        return err;
>  }

I don't remember your answer so again are sure about this? Why can we
remove this now? (I may be missing something here).

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

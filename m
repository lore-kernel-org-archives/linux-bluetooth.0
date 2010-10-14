Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Oct 2010 18:37:10 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Nathan Holstein <nathan.holstein@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix oops in l2cap_connect_req
Message-ID: <20101014213709.GD9250@vigoh>
References: <AANLkTi=CNW1pu-YdvmViqHxfw-_TDzvLkj15Ai_aANWo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=CNW1pu-YdvmViqHxfw-_TDzvLkj15Ai_aANWo@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

* Nathan Holstein <nathan.holstein@gmail.com> [2010-10-14 18:37:53 -0400]:

> (Please keep me in the CC list, I'm not subscribed to lkml)
> 
> [1] L2CAP module dereferences an uninitialized pointer within l2cap_connect_req.
> 
> [2] I'm currently testing a 2.6.35 kernel on a Nexus One with backported
> patches from bluetooth-2.6.  When testing against certain BT devices, I'm seeing
> a null-pointer deref.  The crash is caused by this portion of commit e9aeb2dd:
> 
> @@ -2966,6 +2991,15 @@ sendresp:
>                                         L2CAP_INFO_REQ, sizeof(info), &info);
>         }
> 
> +       if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
> +                               result == L2CAP_CR_SUCCESS) {
> +               u8 buf[128];
> +               l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
> +               l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
> +                                       l2cap_build_conf_req(sk, buf), buf);
> +               l2cap_pi(sk)->num_conf_req++;
> +       }
> +
>         return 0;
>  }
> 
> Multiple error cases jump to the response & sendresp labels prior to
> initializing
> the "sk" variable.  In the case I'm currently seeing, the remote BT
> device fails to
> properly secure the ACL, making this crash 100% reproducible.
> 
> [3] Bluetooth, L2CAP
> 
> [4] This bug appears to be in the mainline 2.6.36-rc? kernel, in addition to
>  multiple Bluetooth development trees
> 
> The following patch fixes the crash.
> 
> 
>    --nathan
> 
> ---
> In error cases when the ACL is insecure or we fail to allocate a new
> struct sock, we jump to the "response" label.  If so, "sk" will be
> uninitialized and the kernel crashes.
> 
> Signed-off-by: Nathan Holstein <nathan.holstein@gmail.com>
> ---
>  net/bluetooth/l2cap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index d527b10..10ae0af 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2911,7 +2911,7 @@ static inline int l2cap_connect_req(struct
> l2cap_conn *conn, struct l2cap_cmd_hd
>  	struct l2cap_chan_list *list = &conn->chan_list;
>  	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
>  	struct l2cap_conn_rsp rsp;
> -	struct sock *parent, *uninitialized_var(sk);
> +	struct sock *parent, *sk = 0;

Your fix is right, but please make *sk = NULL here.
When I wrote that code I thought is was a false positive, but no, it's
bug. :(


-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 17:01:01 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 04/16] Bluetooth: hidp: verify l2cap sockets
Message-ID: <20130226200101.GD10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
 <1361731026-7428-5-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361731026-7428-5-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:54 +0100]:

> We need to verify that the given sockets are actually l2cap sockets. If
> they aren't, we are not supposed to access bt_sk(sock) and we shouldn't
> start the session if the offsets turn out to be valid local BT addresses.

What is the issue you are trying to fix here, I don't get it.

> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/hidp/core.c     | 2 ++
>  net/bluetooth/l2cap_sock.c    | 6 ++++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7588ef4..ae6210e 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -787,6 +787,7 @@ extern bool disable_ertm;
>  
>  int l2cap_init_sockets(void);
>  void l2cap_cleanup_sockets(void);
> +bool is_l2cap_socket(struct socket *s);

Make it l2cap_is_socket() or something like that. Use 'sk' instead of 's'.

	Gustavo

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v4 1/5] Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401703704-22451-2-git-send-email-jukka.rissanen@linux.intel.com>
Date: Mon, 2 Jun 2014 14:09:02 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0270C2F3-6860-47E6-9068-7D1AD91F9F9F@holtmann.org>
References: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com> <1401703704-22451-2-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The l2cap_chan_send() is changed to use kernel memory directly,
> so this function must read the user buffer before sending the
> message.
> 
> The change is done as the 6LoWPAN also uses l2cap_chan_send()
> and in order to minimize the amount of code changes, we must
> copy the user buffer in sock handling code.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/l2cap.h |  4 +--
> net/bluetooth/a2mp.c          | 12 +------
> net/bluetooth/l2cap_core.c    | 81 ++++++++++++++++++++++++-------------------
> net/bluetooth/l2cap_sock.c    | 14 +++++++-
> 4 files changed, 61 insertions(+), 50 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4abdcb2..d9506e0 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -872,8 +872,8 @@ struct l2cap_chan *l2cap_chan_create(void);
> void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		       bdaddr_t *dst, u8 dst_type);
> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> -								u32 priority);
> +int l2cap_chan_send(struct l2cap_chan *chan, void *buf, size_t len,
> +		    u32 priority, unsigned int flags);

sorry for not seeing this earlier. Can this be const void *buf or do we have an issue with casting otherwise?

> void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> int l2cap_chan_check_security(struct l2cap_chan *chan);
> void l2cap_chan_set_defaults(struct l2cap_chan *chan);
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 9514cc9..6b99b1b 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -48,22 +48,12 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
> 	struct l2cap_chan *chan = mgr->a2mp_chan;
> 	struct a2mp_cmd *cmd;
> 	u16 total_len = len + sizeof(*cmd);
> -	struct kvec iv;
> -	struct msghdr msg;
> 
> 	cmd = __a2mp_build(code, ident, len, data);
> 	if (!cmd)
> 		return;
> 
> -	iv.iov_base = cmd;
> -	iv.iov_len = total_len;
> -
> -	memset(&msg, 0, sizeof(msg));
> -
> -	msg.msg_iov = (struct iovec *) &iv;
> -	msg.msg_iovlen = 1;
> -
> -	l2cap_chan_send(chan, &msg, total_len, 0);
> +	l2cap_chan_send(chan, cmd, total_len, 0, 0);
> 
> 	kfree(cmd);
> }
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7468482..e498833 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2104,19 +2104,20 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
> 	}
> }
> 
> -static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> -					 struct msghdr *msg, int len,
> -					 int count, struct sk_buff *skb)
> +static inline int l2cap_copy_into_skbuff(struct l2cap_chan *chan,
> +					 void *buf, int len,
> +					 unsigned int flags, int count,
> +					 struct sk_buff *skb)
> {

Same here, can this be const void *buf?

The rest looks all good to me.

Regards

Marcel


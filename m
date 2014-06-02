Return-Path: <cyrus@holtmann.org>
Message-ID: <1401711834.2400.42.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: Refactor l2cap_sock_sendmsg() to copy
 user buffer
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jun 2014 15:23:54 +0300
In-Reply-To: <0270C2F3-6860-47E6-9068-7D1AD91F9F9F@holtmann.org>
References: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1401703704-22451-2-git-send-email-jukka.rissanen@linux.intel.com>
	 <0270C2F3-6860-47E6-9068-7D1AD91F9F9F@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-06-02 at 14:09 +0200, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > The l2cap_chan_send() is changed to use kernel memory directly,
> > so this function must read the user buffer before sending the
> > message.
> > 
> > The change is done as the 6LoWPAN also uses l2cap_chan_send()
> > and in order to minimize the amount of code changes, we must
> > copy the user buffer in sock handling code.
> > 
> > Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > ---
> > include/net/bluetooth/l2cap.h |  4 +--
> > net/bluetooth/a2mp.c          | 12 +------
> > net/bluetooth/l2cap_core.c    | 81 ++++++++++++++++++++++++-------------------
> > net/bluetooth/l2cap_sock.c    | 14 +++++++-
> > 4 files changed, 61 insertions(+), 50 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 4abdcb2..d9506e0 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -872,8 +872,8 @@ struct l2cap_chan *l2cap_chan_create(void);
> > void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> > int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> > 		       bdaddr_t *dst, u8 dst_type);
> > -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> > -								u32 priority);
> > +int l2cap_chan_send(struct l2cap_chan *chan, void *buf, size_t len,
> > +		    u32 priority, unsigned int flags);
> 
> sorry for not seeing this earlier. Can this be const void *buf or do we have an issue with casting otherwise?

It can and no need to cast. I prepare v5 using const void *buf.


> > -static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> > -					 struct msghdr *msg, int len,
> > -					 int count, struct sk_buff *skb)
> > +static inline int l2cap_copy_into_skbuff(struct l2cap_chan *chan,
> > +					 void *buf, int len,
> > +					 unsigned int flags, int count,
> > +					 struct sk_buff *skb)
> > {
> 
> Same here, can this be const void *buf?
> 

Ditto.



Cheers,
Jukka



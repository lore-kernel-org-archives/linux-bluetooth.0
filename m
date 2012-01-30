Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327936146-13897-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327936146-13897-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 30 Jan 2012 15:26:43 -0200
Message-ID: <CAA37ikYnHLtSGeErJAnbWhKK4ko1Zh=pLhD3qA-PP4Ao3+ekkg@mail.gmail.com>
Subject: Re: [RFCv0 4/5] Bluetooth: Remove unneeded sk variable
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 30, 2012 at 1:09 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> In debug use chan %p instead of sk.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a7e5a55..4a22602 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1589,13 +1589,12 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
>                                                struct msghdr *msg, size_t len,
>                                                u32 priority)
>  {
> -       struct sock *sk = chan->sk;
>        struct l2cap_conn *conn = chan->conn;
>        struct sk_buff *skb;
>        int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
>        struct l2cap_hdr *lh;
>
> -       BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
> +       BT_DBG("chan %p len %d priority %u", chan, (int)len, priority);
>
>        count = min_t(unsigned int, (conn->mtu - hlen), len);
>
> @@ -1625,13 +1624,12 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
>                                                struct msghdr *msg, size_t len,
>                                                u32 priority)
>  {
> -       struct sock *sk = chan->sk;
>        struct l2cap_conn *conn = chan->conn;
>        struct sk_buff *skb;
>        int err, count, hlen = L2CAP_HDR_SIZE;
>        struct l2cap_hdr *lh;
>
> -       BT_DBG("sk %p len %d", sk, (int)len);
> +       BT_DBG("chan %p len %d", chan, (int)len);
>
>        count = min_t(unsigned int, (conn->mtu - hlen), len);
>
> @@ -1660,13 +1658,12 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
>                                                struct msghdr *msg, size_t len,
>                                                u32 control, u16 sdulen)
>  {
> -       struct sock *sk = chan->sk;
>        struct l2cap_conn *conn = chan->conn;
>        struct sk_buff *skb;
>        int err, count, hlen;
>        struct l2cap_hdr *lh;
>
> -       BT_DBG("sk %p len %d", sk, (int)len);
> +       BT_DBG("chan %p len %d", chan, (int)len);
>
>        if (!conn)
>                return ERR_PTR(-ENOTCONN);

This one looks good to me.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

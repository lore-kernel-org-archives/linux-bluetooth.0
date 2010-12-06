Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291573170-3708-3-git-send-email-johan.hedberg@gmail.com>
References: <1291573170-3708-1-git-send-email-johan.hedberg@gmail.com>
	<1291573170-3708-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 6 Dec 2010 09:11:35 -0400
Message-ID: <AANLkTimYKSvo8WpNa-ft61MoBaAgKZxt5j0qVuRBfCb3@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management interface callbacks
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Dec 5, 2010 at 2:19 PM,  <johan.hedberg@gmail.com> wrote:
> +static void cmd_status(struct sock *sk, u16 cmd, u8 status)
> +{

I see some inconsistence on how you calculate struct sizes on this
function. See below...

> +       struct sk_buff *skb;
> +       struct mgmt_hdr *hdr;
> +       struct mgmt_ev_cmd_status *ev;
> +
> +       BT_DBG("sock %p", sk);
> +
> +       skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);

Here you use sizeof(<var>)

> +       if (!skb)
> +               return;
> +
> +       hdr = (void *) skb_put(skb, sizeof(struct mgmt_hdr));

But here you use sizeof(<struct>). Could be sizeof(*hdr) ? Note there
is also the (unused) MGMT_HDR_SIZE.

> +
> +       hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> +       hdr->len = cpu_to_le16(3);

and here a hard-coded size. Could be sizeof(struct mgmt_ev_cmd_status)
? or maybe create a #define for it?

> +
> +       ev = (void *) skb_put(skb, sizeof(*ev));
> +       ev->status = status;
> +       put_unaligned_le16(cmd, &ev->opcode);
> +
> +       if (sock_queue_rcv_skb(sk, skb) < 0)
> +               kfree_skb(skb);
> +}
> +
> +int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> +{
> +       unsigned char *buf;
> +       struct mgmt_hdr *hdr;
> +       u16 opcode, len;
> +       int err;
> +
> +       BT_DBG("got %zu bytes", msglen);
> +
> +       if (msglen < sizeof(*hdr))
> +               return -EINVAL;
> +
> +       buf = kmalloc(msglen, GFP_ATOMIC);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       if (memcpy_fromiovec(buf, msg->msg_iov, msglen)) {
> +               err = -EFAULT;
> +               goto done;
> +       }
> +
> +       hdr = (struct mgmt_hdr *) buf;
> +       opcode = get_unaligned_le16(&hdr->opcode);
> +       len = get_unaligned_le16(&hdr->len);
> +
> +       if (len != msglen - sizeof(struct mgmt_hdr)) {

You could use sizeof(*hdr) here.

> +               err = -EINVAL;
> +               goto done;
> +       }
> +
> +       switch (opcode) {
> +       default:
> +               BT_DBG("Unknown op %u", opcode);
> +               cmd_status(sk, opcode, 0x01);
> +               break;
> +       }
> +
> +       err = msglen;

Would there be a chance of integer overflow here? The function returns
(signed) int, but msglen is (unsigned) size_t.

> +
> +done:
> +       kfree(buf);
> +       return err;
> +}

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

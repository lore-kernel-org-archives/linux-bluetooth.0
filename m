Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
	<1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Nov 2010 16:55:58 +0200
Message-ID: <AANLkTik0x3tjnM85Mu=vwU6GB2pXAgWXnqe28aKS+QkN@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management interface callbacks
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 24, 2010 at 4:39 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
>
> Add initial code for handling Bluetooth Management interface messages.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +
>  net/bluetooth/Makefile           |    2 +-
>  net/bluetooth/hci_sock.c         |   39 +++++++++++++--
>  net/bluetooth/mgmt.c             |   99 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 136 insertions(+), 7 deletions(-)
>  create mode 100644 net/bluetooth/mgmt.c
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b8104af..dd1573da 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -660,6 +660,9 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
>  /* ----- HCI Sockets ----- */
>  void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
>
> +/* Management interface */
> +int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
> +
>  /* HCI info for socket */
>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
>
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index d1e433f..8b411d9 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -10,4 +10,4 @@ obj-$(CONFIG_BT_BNEP) += bnep/
>  obj-$(CONFIG_BT_CMTP)  += cmtp/
>  obj-$(CONFIG_BT_HIDP)  += hidp/
>
> -bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
> +bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o hci_sock.o hci_sysfs.o lib.o
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 83acd16..730a4e8 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -49,6 +49,8 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> +static int enable_mgmt = 0;
> +
>  /* ----- HCI socket interface ----- */
>
>  static inline int hci_test_bit(int nr, void *addr)
> @@ -352,25 +354,35 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long a
>
>  static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>  {
> -       struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
> +       struct sockaddr_hci haddr;
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
> +
> +       if (haddr.hci_family != AF_BLUETOOTH)
> +               return -EINVAL;
> +
> +       if (haddr.hci_channel != HCI_CHANNEL_RAW && !enable_mgmt)
>                return -EINVAL;
>
>        lock_sock(sk);
>
> -       if (hci_pi(sk)->hdev) {
> +       if (sk->sk_state == BT_BOUND || hci_pi(sk)->hdev) {
>                err = -EALREADY;
>                goto done;
>        }
>
> -       if (haddr->hci_dev != HCI_DEV_NONE) {
> -               if (!(hdev = hci_dev_get(haddr->hci_dev))) {
> +       if (haddr.hci_dev != HCI_DEV_NONE) {
> +               if (!(hdev = hci_dev_get(haddr.hci_dev))) {

doesn't checkpatch give errors here? Would be more clean like:
...
hdev = hci_dev_get(haddr.hci_dev);
if (!hdev)
...

At some point shall be fixed in the old code also

otherwise looks fine

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

>                        err = -ENODEV;
>                        goto done;
>                }
> @@ -378,6 +390,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
>                atomic_inc(&hdev->promisc);
>        }
>
> +       hci_pi(sk)->channel = haddr.hci_channel;
>        hci_pi(sk)->hdev = hdev;
>        sk->sk_state = BT_BOUND;
>
> @@ -499,6 +512,17 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>
>        lock_sock(sk);
>
> +       switch (hci_pi(sk)->channel) {
> +       case HCI_CHANNEL_RAW:
> +               break;
> +       case HCI_CHANNEL_CONTROL:
> +               err = mgmt_control(sk, msg, len);
> +               goto done;
> +       default:
> +               err = -EINVAL;
> +               goto done;
> +       }
> +
>        if (!(hdev = hci_pi(sk)->hdev)) {
>                err = -EBADFD;
>                goto done;
> @@ -826,3 +850,6 @@ void __exit hci_sock_cleanup(void)
>
>        proto_unregister(&hci_sk_proto);
>  }
> +
> +module_param(enable_mgmt, bool, 0644);
> +MODULE_PARM_DESC(enable_mgmt, "Enable Management interface");
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> new file mode 100644
> index 0000000..78255f1
> --- /dev/null
> +++ b/net/bluetooth/mgmt.c
> @@ -0,0 +1,99 @@
> +/*
> +   BlueZ - Bluetooth protocol stack for Linux
> +   Copyright (C) 2010  Nokia Corporation
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 as
> +   published by the Free Software Foundation;
> +
> +   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> +   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
> +   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> +   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> +
> +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> +   SOFTWARE IS DISCLAIMED.
> +*/
> +
> +/* Bluetooth HCI Management interface */
> +
> +#include <asm/uaccess.h>
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/mgmt.h>
> +
> +static void cmd_status(struct sock *sk, u16 cmd, u8 status)
> +{
> +       struct sk_buff *skb;
> +       struct mgmt_hdr *hdr;
> +       struct mgmt_ev_cmd_status *ev;
> +
> +       BT_DBG("sock %p", sk);
> +
> +       skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
> +       if (!skb)
> +               return;
> +
> +       hdr = (void *) skb_put(skb, sizeof(struct mgmt_hdr));
> +
> +       hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> +       hdr->len = cpu_to_le16(3);
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
> +
> +done:
> +       kfree(buf);
> +       return err;
> +}
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

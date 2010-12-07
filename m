Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 19:05:27 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [RFC v2 2/9] Bluetooth: Implement the first SMP commands
Message-ID: <20101207220527.GD4797@eris>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
 <1291671832-13435-3-git-send-email-vinicius.gomes@openbossa.org>
 <20101207160307.GB2944@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101207160307.GB2944@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 14:03 Tue 07 Dec, Gustavo F. Padovan wrote:
> Hi Vinicius,
> 
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-12-06 18:43:45 -0300]:
> 
> > These simple commands will allow the SMP procedure to be started
> > and terminated with a not supported error. This is the first step
> > toward something useful.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> > ---
> >  include/net/bluetooth/smp.h             |    4 +
> >  net/bluetooth/Makefile                  |    1 +
> >  net/bluetooth/{l2cap.c => l2cap_core.c} |    0
> 
> I want a separated patch for the l2cap.c rename.
>

Sure. Will do.

> >  net/bluetooth/smp.c                     |  144 +++++++++++++++++++++++++++++++
> >  4 files changed, 149 insertions(+), 0 deletions(-)
> >  rename net/bluetooth/{l2cap.c => l2cap_core.c} (100%)
> >  create mode 100644 net/bluetooth/smp.c
> > 
> > diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
> > index 8f2edbf..b9603cc 100644
> > --- a/include/net/bluetooth/smp.h
> > +++ b/include/net/bluetooth/smp.h
> > @@ -73,4 +73,8 @@ struct smp_cmd_security_req {
> >  #define SMP_UNSPECIFIED		0x08
> >  #define SMP_REPEATED_ATTEMPTS		0x09
> >  
> > +/* SMP Commands */
> > +int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
> > +int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
> > +
> >  #endif /* __SMP_H */
> > diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> > index d1e433f..d138b23 100644
> > --- a/net/bluetooth/Makefile
> > +++ b/net/bluetooth/Makefile
> > @@ -11,3 +11,4 @@ obj-$(CONFIG_BT_CMTP)	+= cmtp/
> >  obj-$(CONFIG_BT_HIDP)	+= hidp/
> >  
> >  bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
> > +l2cap-objs := l2cap_core.o smp.o
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap_core.c
> > similarity index 100%
> > rename from net/bluetooth/l2cap.c
> > rename to net/bluetooth/l2cap_core.c
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > new file mode 100644
> > index 0000000..e427d11
> > --- /dev/null
> > +++ b/net/bluetooth/smp.c
> > @@ -0,0 +1,144 @@
> > +/*
> > +   BlueZ - Bluetooth protocol stack for Linux
> > +   Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
> > +
> > +   This program is free software; you can redistribute it and/or modify
> > +   it under the terms of the GNU General Public License version 2 as
> > +   published by the Free Software Foundation;
> > +
> > +   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> > +   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > +   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
> > +   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
> > +   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
> > +   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> > +   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> > +   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> > +
> > +   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> > +   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> > +   SOFTWARE IS DISCLAIMED.
> > +*/
> > +
> > +#include <net/bluetooth/bluetooth.h>
> > +#include <net/bluetooth/hci_core.h>
> > +#include <net/bluetooth/l2cap.h>
> > +#include <net/bluetooth/smp.h>
> > +
> > +static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
> > +		u16 dlen, void *data)
> > +{
> > +	struct sk_buff *skb;
> > +	struct l2cap_hdr *lh;
> > +	int len;
> > +
> > +	len = L2CAP_HDR_SIZE + 1 + dlen;
> > +
> > +	if (len > conn->mtu)
> > +		return NULL;
> > +
> > +	skb = bt_skb_alloc(len, GFP_ATOMIC);
> > +	if (!skb)
> > +		return NULL;
> > +
> > +	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
> > +	lh->len = cpu_to_le16(1 + dlen);
> > +	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
> > +
> > +	memcpy(skb_put(skb, 1), &code, 1);
> > +
> > +	memcpy(skb_put(skb, dlen), data, dlen);
> > +
> > +	return skb;
> > +}
> > +
> > +static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
> > +{
> > +	struct sk_buff *skb = smp_build_cmd(conn, code, len, data);
> > +
> > +	BT_DBG("code 0x%2.2x", code);
> > +
> > +	if (!skb)
> > +		return;
> > +
> > +	hci_send_acl(conn->hcon, skb, 0);
> > +}
> > +
> > +int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
> > +{
> > +	__u8 authreq;
> > +
> > +	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
> > +
> > +	switch (sec_level) {
> > +	case BT_SECURITY_MEDIUM:
> > +		/* Encrypted, no MITM protection */
> > +		authreq = 0x01;
> > +		break;
> > +
> > +	case BT_SECURITY_HIGH:
> > +		/* Bonding, MITM protection */
> > +		authreq = 0x05;
> > +		break;
> > +
> > +	case BT_SECURITY_LOW:
> > +	default:
> > +		return 1;
> > +	}
> > +
> > +	if (conn->hcon->link_mode & HCI_LM_MASTER) {
> > +		struct smp_cmd_pairing cp;
> > +		cp.io_capability = 0x00;
> > +		cp.oob_flag = 0x00;
> > +		cp.max_key_size = 16;
> > +		cp.init_key_dist = 0x00;
> > +		cp.resp_key_dist = 0x00;
> > +		cp.auth_req = authreq;
> > +		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
> > +	} else {
> > +		struct smp_cmd_security_req cp;
> > +		cp.auth_req = authreq;
> > +		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
> > +{
> > +	__u8 code = skb->data[0];
> > +	__u8 reason;
> > +	int err = 0;
> > +
> > +	skb_pull(skb, 1);
> > +
> > +	switch (code) {
> > +	case SMP_CMD_PAIRING_REQ:
> > +		reason = SMP_PAIRING_NOTSUPP;
> > +		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
> > +		err = -1;
> 
> Don't use -1, use a proper error macro here.

Sure.

> 
> > +		break;
> > +
> > +	case SMP_CMD_PAIRING_FAIL:
> > +		break;
> > +
> > +	case SMP_CMD_PAIRING_RSP:
> > +	case SMP_CMD_PAIRING_CONFIRM:
> > +	case SMP_CMD_PAIRING_RANDOM:
> > +	case SMP_CMD_ENCRYPT_INFO:
> > +	case SMP_CMD_MASTER_IDENT:
> > +	case SMP_CMD_IDENT_INFO:
> > +	case SMP_CMD_IDENT_ADDR_INFO:
> > +	case SMP_CMD_SIGN_INFO:
> > +	case SMP_CMD_SECURITY_REQ:
> > +	default:
> > +		BT_DBG("Unknown command code 0x%2.2x", code);
> > +
> > +		reason = SMP_CMD_NOTSUPP;
> > +		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
> > +		err = -1;
> 
> Same here.

Ok.

> 
> -- 
> Gustavo F. Padovan
> http://profusion.mobi


Cheers,
-- 
Vinicius

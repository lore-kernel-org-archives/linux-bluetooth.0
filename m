Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DBAC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F86128B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFOTjd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:39:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50173 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOTjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:39:32 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id BE483CECFB;
        Tue, 15 Jun 2021 21:45:22 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v9 05/10] Bluetooth: Add BT_CODEC option for getsockopt
 for SCO socket
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210608122455.19583-5-kiran.k@intel.com>
Date:   Tue, 15 Jun 2021 21:37:20 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D0153D80-4C8C-47BF-9455-865D96649268@holtmann.org>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-5-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Add BT_CODEC option for getsockopt systemcall over SCO socket
> to expose the codecs supported by controller
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes on v9:
>  - fix typos,review comments, remove quirk
> 
> include/net/bluetooth/bluetooth.h |  20 ++++++
> include/net/bluetooth/hci.h       |   4 ++
> net/bluetooth/sco.c               | 111 +++++++++++++++++++++++++++++-
> 3 files changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 9125effbf448..1840756958ce 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -153,6 +153,26 @@ struct bt_voice {
> 
> #define BT_SCM_PKT_STATUS	0x03
> 
> +#define BT_CODEC	19
> +
> +struct	bt_codec_caps {
> +	__u8	len;
> +	__u8	data[];
> +} __packed;
> +
> +struct bt_codec {
> +	__u8	id;
> +	__le16	cid;
> +	__le16	vid;
> +	__u8	data_path;
> +	__u8	num_caps;
> +} __packed;
> +
> +struct bt_codecs {
> +	__u8		num_codecs;
> +	struct bt_codec	codecs[];
> +} __packed;
> +
> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 45bd9af4ce61..31a5ac8918fc 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2619,6 +2619,10 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
> #define hci_iso_data_len(h)		((h) & 0x3fff)
> #define hci_iso_data_flags(h)		((h) >> 14)
> 
> +/* codec transport types */
> +#define TRANSPORT_ACL		0x00
> +#define TRANSPORT_SCO_ESCO	0x01
> +
> /* le24 support */
> static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
> {
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index d9a4e88dacbb..98d5e24e5680 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -944,10 +944,15 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 			       char __user *optval, int __user *optlen)
> {
> 	struct sock *sk = sock->sk;
> -	int len, err = 0;
> +	int len, err = 0, buf_len;
> 	struct bt_voice voice;
> 	u32 phys;
> 	int pkt_status;
> +	struct codec_list *c;
> +	u8 num_codecs, i, __user *ptr;
> +	struct hci_dev *hdev;
> +	struct hci_codec_caps *caps;
> +	__u8	data_path;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -1012,6 +1017,110 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 			err = -EFAULT;
> 		break;
> 
> +	case BT_CODEC:
> +		num_codecs = 0;
> +		buf_len = 0;
> +
> +		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
> +		if (!hdev) {
> +			err = -EBADFD;
> +			break;
> +		}
> +
> +		if (!hdev->get_data_path) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		hci_dev_lock(hdev);
> +		/* find total buffer size  required to copy codec + caps */

please check for simple style mistakes like double spaces. Also I would put the comment above the hci_dev_lock().

> +		list_for_each_entry(c, &hdev->local_codecs, list) {
> +			if (c->transport != TRANSPORT_SCO_ESCO)
> +				continue;
> +			num_codecs++;
> +			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
> +				buf_len += 1 + caps->len;
> +				caps = (void *)&caps->data[caps->len];
> +			}
> +			buf_len += sizeof(struct bt_codec);
> +		}
> +		hci_dev_unlock(hdev);
> +
> +		buf_len += sizeof(struct bt_codecs);
> +		if (buf_len > len) {
> +			err = -ENOBUFS;
> +			break;
> +		}
> +		ptr = optval;
> +
> +		if (put_user(num_codecs, ptr)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		ptr += sizeof(num_codecs);
> +

And this is missing comment as well.

> +		hci_dev_lock(hdev);
> +		list_for_each_entry(c, &hdev->local_codecs, list) {
> +			if (c->transport != TRANSPORT_SCO_ESCO)
> +				continue;
> +
> +			if (put_user(c->id, ptr)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += sizeof(c->id);
> +
> +			if (put_user(c->cid, ptr)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += sizeof(c->cid);
> +
> +			if (put_user(c->vid, ptr)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += sizeof(c->vid);
> +
> +			err = hdev->get_data_path(hdev);
> +			if (err < 0) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}

Using the variable name err is really bad here. It is also not an EFAULT type of error. They are really specific. I really don’t get why not prepare the data in advance and have a single put_user call.

> +
> +			data_path = (__u8)err;
> +			if (put_user(data_path, ptr)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += sizeof(data_path);
> +
> +			if (put_user(c->num_caps, ptr)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += sizeof(c->num_caps);
> +
> +			len = 0;
> +			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
> +				len += 1 + caps->len;
> +				caps = (void *)&caps->data[caps->len];
> +			}
> +
> +			if (len && copy_to_user(ptr, c->caps, len)) {
> +				err = -EFAULT;
> +				goto unlock;
> +			}
> +			ptr += len;
> +		}
> +
> +		if (put_user(buf_len, optlen))
> +			err = -EFAULT;
> +unlock:
> +		hci_dev_unlock(hdev);

Jumping from within a for-loop is nothing something that I actually like. It is better you break out of via break.

Regards

Marcel


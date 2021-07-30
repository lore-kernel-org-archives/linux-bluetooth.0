Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86020C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7133A6101C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhG3OOe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:14:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39517 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhG3OO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 10:14:28 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2AFBCCED2F;
        Fri, 30 Jul 2021 16:14:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v11 04/10] Bluetooth: Allow querying of supported offload
 codecs over SCO socket
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210727084713.23038-4-kiran.k@intel.com>
Date:   Fri, 30 Jul 2021 16:14:18 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <DF716A96-0774-4CD2-B2B9-95D41F1B0842@holtmann.org>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-4-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Add BT_CODEC option for getsockopt systemcall to get the details
> of offload codecs supported over SCO socket
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v11:
>  - Remove Kconfig related changes
> * changes in v10:
>  - In getsockopt, prepare data in advance and call copy_to_user
>    istead of calling put_user on each field of struct bt_codec
> 
> include/net/bluetooth/bluetooth.h | 20 +++++++
> include/net/bluetooth/hci.h       |  4 ++
> include/net/bluetooth/hci_core.h  |  1 +
> net/bluetooth/sco.c               | 91 +++++++++++++++++++++++++++++++
> 4 files changed, 116 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 9125effbf448..64cddff0c9c4 100644
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
> +	__u16	cid;
> +	__u16	vid;
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
> index b4e35cf5f4b1..22e872e60ff8 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2621,6 +2621,10 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
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
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6742e6ad7b37..71c409c8ab34 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -617,6 +617,7 @@ struct hci_dev {
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> 	void (*cmd_timeout)(struct hci_dev *hdev);
> 	bool (*prevent_wake)(struct hci_dev *hdev);
> +	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> };
> 
> #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index ffa2a77a3e4c..2f32693f09c1 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -953,6 +953,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 	struct bt_voice voice;
> 	u32 phys;
> 	int pkt_status;
> +	int buf_len;
> +	struct codec_list *c;
> +	u8 num_codecs, i, __user *ptr;
> +	struct hci_dev *hdev;
> +	struct hci_codec_caps *caps;
> +	struct bt_codec codec;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -1017,6 +1023,91 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
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
> +		if (!hdev->get_data_path_id) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}

so I did say that this needs to be put behind an experimental feature setting. I am not committing to an userspace API until we have more feedback.

Regards

Marcel


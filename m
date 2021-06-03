Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46680C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B98613F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFCOi6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:38:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56696 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOi5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:38:57 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE852CED1F;
        Thu,  3 Jun 2021 16:45:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v8 7/9] Bluetooth: Add BT_CODEC option for setsockopt over
 SCO
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518104232.5431-7-kiran.k@intel.com>
Date:   Thu, 3 Jun 2021 16:37:11 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D03E9AAE-842C-4148-8C68-EBFE97A1FFA2@holtmann.org>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-7-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Add BT_CODEC option on setsockopt system call to allow user space
> audio modules to set codec. Driver also configures codec if non-HCI
> data is selected.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  2 +
> net/bluetooth/sco.c               | 63 +++++++++++++++++++++++++++++++
> 2 files changed, 65 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 1840756958ce..0e8802d09068 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -173,6 +173,8 @@ struct bt_codecs {
> 	struct bt_codec	codecs[];
> } __packed;
> 
> +#define CODING_FORMAT_CVSD	0x02
> +
> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index d66293d1cba4..d59f30fc4b9f 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -67,6 +67,7 @@ struct sco_pinfo {
> 	__u32		flags;
> 	__u16		setting;
> 	__u8		cmsg_mask;
> +	struct bt_codec codec;
> 	struct sco_conn	*conn;
> };
> 
> @@ -438,6 +439,7 @@ static void __sco_sock_close(struct sock *sk)
> 		sock_set_flag(sk, SOCK_ZAPPED);
> 		break;
> 	}
> +
> }
> 
> /* Must be called on unlocked socket. */
> @@ -499,6 +501,10 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
> 	sk->sk_state    = BT_OPEN;
> 
> 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
> +	sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
> +	sco_pi(sk)->codec.cid = 0xffff;
> +	sco_pi(sk)->codec.vid = 0xffff;
> +	sco_pi(sk)->codec.data_path = 0x00;
> 
> 	timer_setup(&sk->sk_timer, sco_sock_timeout, 0);
> 
> @@ -808,6 +814,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 	struct sock *sk = sock->sk;
> 	int len, err = 0;
> 	struct bt_voice voice;
> +	struct bt_codecs *codecs;
> +	struct hci_dev *hdev;
> +	__u8 buffer[255];
> 	u32 opt;
> 
> 	BT_DBG("sk %p", sk);
> @@ -870,6 +879,60 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 			sco_pi(sk)->cmsg_mask &= SCO_CMSG_PKT_STATUS;
> 		break;
> 
> +	case BT_CODEC:
> +		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
> +		    sk->sk_state != BT_CONNECT2) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
> +		if (!hdev) {
> +			err = -EBADFD;
> +			break;
> +		}
> +
> +		if (!test_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks)) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}

Same here. Just check the configure_data_path (and I think set_data_path is better and shorter) is available, if not bail our here right away instead checking this over and over again later.

> +
> +		if (optlen < sizeof(struct bt_codecs) || optlen > 255) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (copy_from_sockptr(buffer, optval, optlen)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +		codecs = (void *)buffer;
> +
> +		if (codecs->num_codecs > 1) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (codecs->codecs[0].data_path) {
> +			if (!hdev->configure_data_path) {
> +				err = -EOPNOTSUPP;
> +				break;
> +			}
> +			err = hdev->configure_data_path(hdev, SCO_LINK,
> +							codecs->codecs);
> +			if (err < 0)
> +				break;
> +
> +			if (codecs->codecs[0].id == 0xff) {
> +				sco_pi(sk)->codec.cid = codecs->codecs[0].cid;
> +				sco_pi(sk)->codec.vid = codecs->codecs[0].vid;
> +			}
> +		}
> +		sco_pi(sk)->codec.id = codecs->codecs[0].id;
> +		sco_pi(sk)->codec.data_path = codecs->codecs[0].data_path;
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;

Regards

Marcel


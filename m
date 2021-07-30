Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68301C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A4A60F94
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhG3OSD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:18:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35008 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbhG3OR0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:26 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id EB77CCED30;
        Fri, 30 Jul 2021 16:17:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
 offload usecase
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210727084713.23038-6-kiran.k@intel.com>
Date:   Fri, 30 Jul 2021 16:17:20 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2E192E47-B47A-4464-A5D5-3DC34DD22ECF@holtmann.org>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-6-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> For HFP offload usecase, controller needs to be configured
> with codec data and capabilities. This patch uses Bluetooth
> SIG defined command HCI_CONFIGURE_DATA_PATH to specify vendor
> specific data and allows userspace modules to set the codec
> via setsockopt systemcall.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v11:
>  - Remove changes related to Kconfig
> * changes in v10:
>  - patch refactor - having callback definition and usage in the same patch
> 
> include/net/bluetooth/bluetooth.h |   2 +
> include/net/bluetooth/hci.h       |   8 ++
> include/net/bluetooth/hci_core.h  |   3 +
> net/bluetooth/sco.c               | 118 ++++++++++++++++++++++++++++++
> 4 files changed, 131 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 64cddff0c9c4..1a48b6732eef 100644
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
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 22e872e60ff8..c998607fc517 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
> 	__u8     rand256[16];
> } __packed;
> 
> +#define HCI_CONFIGURE_DATA_PATH	0x0c83
> +struct hci_op_configure_data_path {
> +	__u8	direction;
> +	__u8	data_path_id;
> +	__u8	vnd_len;
> +	__u8	vnd_data[];
> +} __packed;
> +
> #define HCI_OP_READ_LOCAL_VERSION	0x1001
> struct hci_rp_read_local_version {
> 	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 71c409c8ab34..eafa6f8114cb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -618,6 +618,9 @@ struct hci_dev {
> 	void (*cmd_timeout)(struct hci_dev *hdev);
> 	bool (*prevent_wake)(struct hci_dev *hdev);
> 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> +	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> +				     struct bt_codec *codec, __u8 *vnd_len,
> +				     __u8 **vnd_data);

why are these two independent callbacks? I seem to remember saying that it looks like we only need one.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B499C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752D661019
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhG3OHs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:07:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52106 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbhG3OHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 10:07:46 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4C1C3CED2F;
        Fri, 30 Jul 2021 16:07:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v11 02/10] Bluetooth: Add support for Read Local Supported
 Codecs V2
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210727084713.23038-2-kiran.k@intel.com>
Date:   Fri, 30 Jul 2021 16:07:40 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0461C975-82DC-4C4F-8CA6-6D4D7289FFF8@holtmann.org>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-2-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Use V2 version of read local supported command is controller
> supports
> 
> snoop:
>> HCI Event: Command Complete (0x0e) plen 20
>      Read Local Supported Codecs V2 (0x04|0x000d) ncmd 1
>        Status: Success (0x00)
>        Number of supported codecs: 7
>          Codec: u-law log (0x00)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: A-law log (0x01)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: CVSD (0x02)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Transparent (0x03)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Linear PCM (0x04)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Reserved (0x08)
>          Logical Transport Type: 0x03
>            Codec supported over BR/EDR ACL
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: mSBC (0x05)
>          Logical Transport Type: 0x03
>            Codec supported over BR/EDR ACL
>            Codec supported over BR/EDR SCO and eSCO
>        Number of vendor codecs: 0
> ......
> < HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
>        Codec: mSBC (0x05)
>        Logical Transport Type: 0x00
>        Direction: Input (Host to Controller) (0x00)
>> HCI Event: Command Complete (0x0e) plen 12
>      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
>        Status: Success (0x00)
>        Number of codec capabilities: 1
>         Capabilities #0:
>        00 00 11 15 02 33
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v11:
>  - Remove Kconfig related changes
>  - Move codec related functions to hci_codec.c
> 
> * changes in v10:
>  no changes
> 
> * changes in v9:
>  use vnd as shortcut name for vendor instead of ven
> 
> * changes in v8:
>  no changes
> 
> * changes in v7:
>  call codec enumeration code in hci_init instead of having it in a separate
>  function
> 
> * changes in v6
>  no changes
> 
> * changes in v5:
>  fix review comments
> 
> * changes in v4:
>  converts codec read capabilities calls from async to sync
> 
> * changes in v3:
>  No changes
> 
> * changes in v2:
>  add length check for event data before accessing
> include/net/bluetooth/hci.h | 29 +++++++++++++++
> net/bluetooth/hci_codec.c   | 74 +++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_codec.h   |  1 +
> net/bluetooth/hci_core.c    |  4 +-
> 4 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index f76849c8eafd..b4e35cf5f4b1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1337,6 +1337,35 @@ struct hci_rp_read_local_pairing_opts {
> 	__u8     max_key_size;
> } __packed;
> 
> +#define HCI_OP_READ_LOCAL_CODECS_V2	0x100d
> +struct hci_std_codec_v2 {
> +	__u8	id;
> +	__u8	transport;
> +} __packed;
> +
> +struct hci_std_codecs_v2 {
> +	__u8	num;
> +	struct hci_std_codec_v2 codec[];
> +} __packed;
> +
> +struct hci_vnd_codec_v2 {
> +	__u8	id;
> +	__le16	cid;
> +	__le16	vid;
> +	__u8	transport;
> +} __packed;
> +
> +struct hci_vnd_codecs_v2 {
> +	__u8	num;
> +	struct hci_vnd_codec_v2 codec[];
> +} __packed;
> +
> +struct hci_rp_read_local_supported_codecs_v2 {
> +	__u8	status;
> +	struct hci_std_codecs_v2 std_codecs;
> +	struct hci_vnd_codecs_v2 vendor_codecs;
> +} __packed;
> +
> #define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
> struct hci_op_read_local_codec_caps {
> 	__u8	id;
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 205f3b04c172..6f20a4b1fc9c 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -192,3 +192,77 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
> error:
> 	kfree_skb(skb);
> }
> +
> +static void hci_codec_list_parse_v2(struct hci_dev *hdev, __u8 num_codecs,
> +				    void *codec_list, bool is_vnd_codec)
> +{
> +	__u8 i;
> +
> +	for (i = 0; i < num_codecs; i++) {
> +		if (!is_vnd_codec) {
> +			struct hci_std_codecs_v2 *codecs = codec_list;
> +
> +			hci_read_codec_capabilities(hdev, &codecs->codec[i],
> +						    codecs->codec[i].transport,
> +						    is_vnd_codec);
> +		} else {
> +			struct hci_vnd_codecs_v2 *codecs = codec_list;
> +
> +			hci_read_codec_capabilities(hdev, &codecs->codec[i],
> +						    codecs->codec[i].transport,
> +						    is_vnd_codec);
> +		}
> +	}
> +}
> +
> +void hci_read_supported_codecs_v2(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_supported_codecs_v2 *rp;
> +	struct hci_std_codecs_v2 *std_codecs;
> +	struct hci_vnd_codecs_v2 *vnd_codecs;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
> +			     HCI_CMD_TIMEOUT);
> +
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
> +			   PTR_ERR(skb));
> +		return;
> +	}
> +
> +	if (skb->len < sizeof(*rp))
> +		goto error;
> +
> +	rp = (void *)skb->data;
> +
> +	if (rp->status)
> +		goto error;
> +
> +	skb_pull(skb, sizeof(rp->status));
> +
> +	std_codecs = (void *)skb->data;
> +
> +	/* check for payload data length before accessing */
> +	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
> +	    + sizeof(std_codecs->num))
> +		goto error;
> +
> +	hci_codec_list_parse_v2(hdev, std_codecs->num, std_codecs, false);
> +
> +	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
> +		 + sizeof(std_codecs->num));
> +
> +	vnd_codecs = (void *)skb->data;
> +
> +	/* check for payload data length before accessing */
> +	if (skb->len <
> +	    flex_array_size(vnd_codecs, codec, vnd_codecs->num)
> +	    + sizeof(vnd_codecs->num))
> +		goto error;
> +
> +	hci_codec_list_parse_v2(hdev, vnd_codecs->num, vnd_codecs, true);
> +
> +error:
> +	kfree_skb(skb);
> +}

once you apply my comments from the previous patch to this one as well, you will see that it looks a lot less complicated and entangled.

Regards

Marcel


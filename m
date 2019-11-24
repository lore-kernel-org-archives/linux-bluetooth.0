Return-Path: <SRS0=IqEA=ZQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20570C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9C32073F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfKXLEl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:04:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42562 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKXLEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Nov 2019 06:04:41 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9E84ECECD5;
        Sun, 24 Nov 2019 12:13:47 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191121224455.orhslaa6zdmlwe43@pali>
Date:   Sun, 24 Nov 2019 12:04:39 +0100
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
References: <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali> <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali> <20191121224455.orhslaa6zdmlwe43@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>> I was playing with another suggestion for API:
>> 
>> +#define BT_VOICE_SETUP		14
>> +struct bt_voice_pkt_type {
>> +	__u8 capability; /* 0x01 - SCO; 0x02 - eSCO */
>> +	__u8 retrans_effort;
>> +	__u16 pkt_type;
>> +	__u16 max_latency;
>> +};
>> +struct bt_voice_setup {
>> +	__u16 voice_setting;
>> +	__u16 pkt_types_count;
>> +	__u32 tx_bandwidth;
>> +	__u32 rx_bandwidth;
>> +	struct bt_voice_pkt_type pkt_types[];
>> +};
>> 
>> So voice_setttings, pkt_types_count and badwidth would not be repeated
>> as it is same for every pkt_type/retrans_effors/max_latency.
>> 
>> But above uses C99 flexible arrays, so I do not know if API kernel <-->
>> userspace API is allowed to use C99 flexible arrays.
>> 
>> But getsockopt/setsockopt functions are possible to write with above
>> API.
> 
> I played more with C99 flexible arrays and seems that gcc supports it
> without any problems. I'm sending another attempt of API implementation,
> now with more fields which are needed for Enhanced Setup Synchronous
> Connection command. This command is not supported by kernel yet, but
> should be easy to add it. So my ioctl API is prepared for it. Enhanced
> Setup Synchronous Connection command would be needed to use hardware
> mSBC codec encoder/decoder.
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index fabee6db0abb..29590c6749d5 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -116,12 +116,49 @@ struct bt_voice {
> 	__u16 setting;
> };
> 
> -#define BT_VOICE_TRANSPARENT			0x0003
> -#define BT_VOICE_CVSD_16BIT			0x0060
> -
> #define BT_SNDMTU		12
> #define BT_RCVMTU		13
> 
> +#define BT_VOICE_SETUP		14
> +#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
> +#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
> +struct bt_voice_pkt_type {
> +	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> +	__u8 retrans_effort;
> +	__u16 pkt_type;
> +	__u16 max_latency;
> +};
> +#define BT_VOICE_SETUP_FEATURE_CONFIG		BIT(0) /* Additional configuration fields after voice_settings are set (including other features) */
> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO		BIT(1) /* Can use Add Synchronous Connection */
> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO	BIT(2) /* Can use Setup Synchronous Connection */
> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO	BIT(3) /* Can use Enhanced Setup Synchronous Connection */
> +struct bt_voice_setup {
> +	__u16 voice_setting;
> +	__u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> +	__u8 pkt_types_count;
> +	__u32 tx_bandwidth;
> +	__u32 rx_bandwidth;
> +	__u32 input_bandwidth;
> +	__u32 output_bandwidth;
> +	__u8 tx_coding_format[5];
> +	__u8 rx_coding_format[5];
> +	__u8 input_coding_format[5];
> +	__u8 output_coding_format[5];
> +	__u16 tx_codec_frame_size;
> +	__u16 rx_codec_frame_size;
> +	__u16 input_coded_data_size;
> +	__u16 output_coded_data_size;
> +	__u8 input_pcm_data_format;
> +	__u8 output_pcm_data_format;
> +	__u8 input_pcm_msb_position;
> +	__u8 output_pcm_msb_position;
> +	__u8 input_data_path;
> +	__u8 output_data_path;
> +	__u8 input_unit_size;
> +	__u8 output_unit_size;
> +	struct bt_voice_pkt_type pkt_types[];
> +};
> +

lets not mush these together. One of these are air codecs and setup defined by a profile, the other are local codec path defined by the platform.

You will also not have multiple local codec path. That will be one and they will not be negotiated. The eSCO settings however will be negotiated.

Regards

Marcel


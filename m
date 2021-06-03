Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8556C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E9F613BA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFCO0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:26:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54867 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCO0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:26:43 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31F0CCED1F;
        Thu,  3 Jun 2021 16:32:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v8 2/9] Bluetooth: Add support for Read Local Supported
 Codecs V2
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518104232.5431-2-kiran.k@intel.com>
Date:   Thu, 3 Jun 2021 16:24:58 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <13F76788-E2D9-4300-A129-A99A75FDD7DF@holtmann.org>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-2-kiran.k@intel.com>
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
> 
> include/net/bluetooth/hci.h | 29 ++++++++++++++
> net/bluetooth/hci_core.c    | 78 ++++++++++++++++++++++++++++++++++++-
> 2 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 6cb9340a2d51..08508b3d13b4 100644
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
> +struct hci_ven_codec_v2 {
> +	__u8	id;
> +	__le16	cid;
> +	__le16	vid;
> +	__u8	transport;
> +} __packed;

See comment from previous patch.

Regards

Marcel


Return-Path: <SRS0=5F6V=MQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1168C64EBC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721B420877
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 20:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721B420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJEDfF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:35:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43987 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJEDfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Oct 2018 23:35:04 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id E4B3ECF367;
        Thu,  4 Oct 2018 22:47:24 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 2/2] Bluetooth : Errata Service Release 8, Erratum 3253
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1538630987-4476-2-git-send-email-mallikarjun.phulari@intel.com>
Date:   Thu, 4 Oct 2018 22:40:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A07D3149-7190-44BC-BF70-E59EAD8241E6@holtmann.org>
References: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
 <1538630987-4476-2-git-send-email-mallikarjun.phulari@intel.com>
To:     Mallikarjun Phulari <mallikarjun.phulari@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mallikarjun,

> L2CAP: New result values
> 	0x0006 - Connection refused – Invalid Source CID
> 	0x0007 - Connection refused – Source CID already allocated
> 
> As per the ESR08_V1.0.0, 1.11.2 Erratum 3253, Page No. 54,
> "Remote CID invalid Issue".
> Applies to Core Specification versions: V5.0, V4.2, v4.1, v4.0, and v3.0 + HS
> Vol 3, Part A, Section 4.2, 4.3, 4.14, 4.15.
> 
> Core Specification Version 5.0, Page No.1753, Table 4.6 and
> Page No. 1767, Table 4.14
> 
> New result values are added to l2cap connect/create channel response as
> 0x0006 - Connection refused – Invalid Source CID
> 0x0007 - Connection refused – Source CID already allocated
> 
> Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
> ---
> include/net/bluetooth/l2cap.h |  6 ++++++
> net/bluetooth/l2cap_core.c    | 17 ++++++++++++++++-
> 2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 35788d9..fd3998a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -275,6 +275,10 @@ struct l2cap_conn_rsp {
>  * And changing the old result value wherever they were used
>  */
> 
> +/* Adding two new connect/create channel results
> + * As per ESR08_V1.0.0, Erratum 3253
> + */
> +

what is this doing in the code? This is for the commit message.

> /* connect/create channel results */
> #define L2CAP_CR_SUCCESS		0x0000
> #define L2CAP_CR_PEND			0x0001
> @@ -282,6 +286,8 @@ struct l2cap_conn_rsp {
> #define L2CAP_CR_SEC_BLOCK		0x0003
> #define L2CAP_CR_NO_MEM			0x0004
> #define L2CAP_CR_BAD_AMP		0x0005
> +#define L2CAP_CR_INVALID_SCID		0x0006
> +#define L2CAP_CR_SCID_IN_USE		0x0007
> #define L2CAP_CR_LE_AUTHENTICATION	0x0005
> #define L2CAP_CR_LE_AUTHORIZATION	0x0006
> #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1c49419..85179ac 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3815,9 +3815,24 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> 
> 	result = L2CAP_CR_NO_MEM;
> 
> +	/* As per ESR08_V1.0.0, Erratum 3253, check the CID is in valid
> +	 * dynamic range and is not allocated already.
> +	 * Send the new result values accordingly
> +	 */
> +
> +	/* Check for valid dynamic CID range */

	/* Check for valid dynamic CID range (as per Erratum 3253) */

And then scrap the other comments above.

> +	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
> +		result = L2CAP_CR_INVALID_SCID;
> +		chan = NULL;
> +		goto response;
> +	}
> +
> 	/* Check if we already have channel with that dcid */
> -	if (__l2cap_get_chan_by_dcid(conn, scid))
> +	if (__l2cap_get_chan_by_dcid(conn, scid)) {
> +		result = L2CAP_CR_SCID_IN_USE;
> +		chan = NULL;

I do not get this chan = NULL setting here (and above as well). I was not needed before, why is it needed now?

> 		goto response;
> +	}
> 
> 	chan = pchan->ops->new_connection(pchan);
> 	if (!chan)

Regards

Marcel


Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E3E2081A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 06:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLGiY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:38:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51498 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFLGiY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 02:38:24 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id F1604CECFF;
        Fri, 12 Jun 2020 08:48:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/3] mgmt: read/set system parameter definitions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200610200452.107406-2-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 08:38:22 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B352FD3A-7E85-482C-B893-9F1F778812EF@holtmann.org>
References: <20200610200452.107406-1-alainm@chromium.org>
 <20200610200452.107406-2-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This patch submits the corresponding kernel definitions to mgmt.h.
> This is submitted before the implementation to avoid any conflicts in
> values allocations.
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Yu Liu <yudiliu@google.com>
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>

one think that I forgot to mention, you start with the authors signed-off-by and after that you include other signed-off-by, reviewed-by, tested-by, acked-by etc. You should be able to read this top to bottom as the history of the patch.

> ---
> 
> Changes in v2:
> - Renamed the mgmt.h per Marcel's comments.
> - Addressed Marcel's comments in the implementation.
> 
> include/net/bluetooth/mgmt.h | 30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 16e0d87bd8fa..09452d2ea6d3 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -702,6 +702,36 @@ struct mgmt_rp_set_exp_feature {
> 	__le32 flags;
> } __packed;
> 
> +#define MGMT_OP_READ_DEF_SYSTEM_CONFIG	0x004b
> +
> +struct mgmt_tlv {
> +	__u16 type;
> +	__u8  length;
> +	__u8  value[];
> +} __packed;
> +
> +struct mgmt_rp_read_default_system_config {
> +	__u8 parameters[0]; /* mgmt_tlv */

There are ongoing attempts to use var[] instead of var[0] to standardize on more restrict C standards and its interpretations.

In addition, I would shortcut parameters to params[] here. I can fix this up for you since I just saw you send a v4 as well.

Regards

Marcel


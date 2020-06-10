Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E175CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24182067B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgFJOQl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:16:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33011 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgFJOQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 10:16:41 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7CEBCECE6;
        Wed, 10 Jun 2020 16:26:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1 1/3] mgmt: read/set system parameter definitions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200609140351.153833-2-alainm@chromium.org>
Date:   Wed, 10 Jun 2020 16:16:38 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F728221B-1F3D-421C-9164-BF6D3C9F6A41@holtmann.org>
References: <20200609140351.153833-1-alainm@chromium.org>
 <20200609140351.153833-2-alainm@chromium.org>
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
> ---
> 
> include/net/bluetooth/mgmt.h | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 16e0d87bd8fa..1081e371f03d 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -702,6 +702,24 @@ struct mgmt_rp_set_exp_feature {
> 	__le32 flags;
> } __packed;
> 
> +#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS	0x004b
> +

I would go for MGMT_OP_READ_DEF_SYSTEM_CONFIG or MGMT_OP_READ_DEFAULT_SYSTEM_CONFIG to match the name in the mgmt-api.txt more closely.

> +struct mgmt_system_parameter_tlv {
> +	__u16 type;
> +	__u8  length;
> +	__u8  value[];
> +} __packed;
> +

Can we just introduce a generic mgmt_tlv {} struct. I think we could use it more broadly. However I wonder if we need it actually since have the EIR parsing support. Maybe just extend that one.

> +struct mgmt_rp_read_default_system_parameters {
> +	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
> +} __packed;
> +
> +#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS	0x004c

Similar to the comment above.

> +
> +struct mgmt_cp_set_default_system_parameters {
> +	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
> +} __packed;
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;

If you have a chance, please also add MGMT_OP_{READ,SET}_DEF_RUNTIME_CONFIG as well. If not, then I am going to send out a patch for that by myself.

Regards

Marcel


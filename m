Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FA42081A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFLNqi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:46:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38352 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFLNqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:46:38 -0400
Received: from marcel-macbook.fritz.box (ip-109-41-64-170.web.vodafone.de [109.41.64.170])
        by mail.holtmann.org (Postfix) with ESMTPSA id EC2C1CED04;
        Fri, 12 Jun 2020 15:56:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/3] mgmt: read/set system parameter definitions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611020157.70230-2-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 15:46:36 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <738ADF85-6602-4CFF-AB50-E17829624246@holtmann.org>
References: <20200611020157.70230-1-alainm@chromium.org>
 <20200611020157.70230-2-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

please remember to put Bluetooth: as prefix in the subject. I fixed this up for you.

> This patch submits the corresponding kernel definitions to mgmt.h.
> This is submitted before the implementation to avoid any conflicts in
> values allocations.
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Yu Liu <yudiliu@google.com>

Please put these behind your Signed-off-by line. I changed this for you.

> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v3:
> - Fixed sparse errors
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

I changed this to __le16 since we developed mgmt as little-endian. I missed this before and fixed this up as well.

> +	__u8  length;
> +	__u8  value[];
> +} __packed;
> +
> +struct mgmt_rp_read_default_system_config {
> +	__u8 parameters[0]; /* mgmt_tlv */

I changed this to params[] to follow recent global style changes. And hmmm, that seems to be not possible with no other values.

./include/net/bluetooth/mgmt.h:714:7: error: flexible array member in a struct with no named members
  714 |  __u8 params[]; /* mgmt_tlv */
      |       ^~~~~~

Maybe we need to leave these structs out since they only contain TLVs anyway.

> +} __packed;
> +
> +#define MGMT_OP_SET_DEF_SYSTEM_CONFIG	0x004c
> +
> +struct mgmt_cp_set_default_system_config {
> +	__u8 parameters[0]; /* mgmt_tlv */
> +} __packed;
> +
> +#define MGMT_OP_READ_DEF_RUNTIME_CONFIG	0x004d
> +
> +struct mgmt_rp_read_default_runtime_config {
> +	__u8 parameters[0]; /* mgmt_tlv */
> +} __packed;
> +
> +#define MGMT_OP_SET_DEF_RUNTIME_CONFIG	0x004e
> +
> +struct mgmt_cp_set_default_runtime_config {
> +	__u8 parameters[0]; /* mgmt_tlv */
> +} __packed;
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;

Other than that patch has been applied to bluetooth-next tree.

Regards

Marcel


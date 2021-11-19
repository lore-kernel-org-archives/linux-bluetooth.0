Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6FF61A53
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhKSKJM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:09:12 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55819 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSKJM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 05:09:12 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 258CDCED22;
        Fri, 19 Nov 2021 11:06:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 1/9] adapter: Enable MSFT a2dp offload codec when
 Experimental is set
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
Date:   Fri, 19 Nov 2021 11:06:09 +0100
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <089A59F0-C858-43BF-80AC-0C384799A87F@holtmann.org>
References: <20211119094235.2432-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> This enables codec offload experimental feature if its UUIDs has been
> enabled by main.conf:Experimental or -E has been passed in the command
> line.
> ---
> src/adapter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> src/main.c    |  1 +
> src/main.conf |  1 +
> 3 files changed, 45 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 309956bbb5be..1627cc127057 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -142,6 +142,13 @@ static const struct mgmt_exp_uuid codec_offload_uuid = {
> 	.str = "a6695ace-ee7f-4fb9-881a-5fac66c629af"
> };
> 
> +/* 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 */
> +static const struct mgmt_exp_uuid msft_a2dp_offload_codecs_uuid = {
> +	.val = { 0x35, 0x83, 0xbc, 0x7c, 0x7e, 0xb9, 0x13, 0xb3,
> +		0xd1, 0x4c, 0xf0, 0x96, 0x1f, 0x13, 0xc2, 0x0c},
> +	.str = "0cc2131f-96f0-4cd1-b313-b97e7cbc8335"
> +};
> +
> static DBusConnection *dbus_conn = NULL;
> 
> static uint32_t kernel_features = 0;
> @@ -9789,6 +9796,41 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
> 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
> }
> 
> +static void msft_a2dp_offload_complete(uint8_t status, uint16_t len,
> +				       const void *param, void *user_data)
> +{
> +	struct btd_adapter *adapter = user_data;
> +	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
> +
> +	if (status != 0) {
> +		error("Set MSFT a2dp offload codec failed with status 0x%02x (%s)",
> +		       status, mgmt_errstr(status));
> +		return;
> +	}
> +
> +	DBG("MSFT a2dp offload codecs successfully set");

we need to switch to using btd_debug or DBG_IDX to include the index number in the traces.

> +
> +	if (action)
> +		queue_push_tail(adapter->exps,
> +				(void *)msft_a2dp_offload_codecs_uuid.val);
> +}
> +
> +static void msft_a2dp_offload_func(struct btd_adapter *adapter, uint8_t action)
> +{
> +	struct mgmt_cp_set_exp_feature cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	memcpy(cp.uuid, msft_a2dp_offload_codecs_uuid.val, 16);
> +	cp.action = action;
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> +		      adapter->dev_id, sizeof(cp), &cp,
> +		      msft_a2dp_offload_complete, adapter, NULL) > 0)
> +		return;
> +
> +	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
> +}

We are no longer dealing with the blunt copy-and-paste mistakes, please do a proper review before sending any patch.

Regards

Marcel


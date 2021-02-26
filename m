Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48276C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BFB64F0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBZUXS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:23:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38689 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhBZUUf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:20:35 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 48DB9CEC82;
        Fri, 26 Feb 2021 21:27:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v1] Bluetooth: Tolerate valid pre 4.2 conn params
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210217142511.3221605-1-alainm@chromium.org>
Date:   Fri, 26 Feb 2021 21:19:52 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Harry Cutts <hcutts@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <16346FE7-7DD1-4575-8EAC-6B7AE6AAAA99@holtmann.org>
References: <20210217142511.3221605-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This patch tolerates connection parameters that were valid before
> ESR08_v1.0.0 which was also incoporated into the 4.2 core specification.
> 
> In particular, this addresses compatibility issues with the Lenovo Yoga
> Mouse that sees its connection parameters rejected by the max_latency
> computation in hci_conn_check_params, but was perfectly valid at the
> time this mouse was qualified.
> 
> Before the patch, the mouse was extremely laggy, after the patch, the
> mouse worked as expected.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Tested-by: Harry Cutts <hcutts@chromium.org>
> 
> ---
> 
> include/net/bluetooth/hci_core.h | 30 ++++++++++++++++++++++++++++++
> net/bluetooth/l2cap_core.c       | 12 ++++++++++++
> 2 files changed, 42 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ebdd4afe30d2..67b75077c82e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1646,6 +1646,36 @@ static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
> 	return hci_find_irk_by_rpa(hdev, bdaddr);
> }
> 
> +/* Erratum 5412 which has been fixed in 4.2 changed the validation of
> + * connection parameters.  For backwards compatibility reasons, the old
> + * calculation must be tolerated.
> + * For further details :
> + * https://www.bluetooth.org/errata/errata_view.cfm?errata_id=5419
> + */
> +static inline int hci_check_conn_params_legacy(u16 min, u16 max, u16 latency,
> +					u16 to_multiplier)

I would not bother with “inline” here. Let the compiler decide.

> +{
> +	u16 max_latency;
> +
> +	if (min > max || min < 6 || max > 3200)
> +		return -EINVAL;
> +
> +	if (to_multiplier < 10 || to_multiplier > 3200)
> +		return -EINVAL;
> +
> +	if (max >= to_multiplier * 8)
> +		return -EINVAL;
> +
> +	max_latency = (to_multiplier * 8 / max) - 1;
> +	if (latency > 499 || latency > max_latency)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Connection Parameter Validation Helper.
> + * See Vol 6, Part B, section 4.5.1.
> + */
> static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
> 					u16 to_multiplier)
> {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 72c2f5226d67..726e78bd85ff 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5553,6 +5553,18 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
> 	memset(&rsp, 0, sizeof(rsp));
> 
> 	err = hci_check_conn_params(min, max, latency, to_multiplier);
> +	if (err) {
> +		BT_WARN("Invalid conn params min 0x%4.4x max 0x%4.4x latency: 0x%4.4x TO: 0x%4.4x",
> +			min, max, latency, to_multiplier);

Can we use bt_dev_warn() here?

> +
> +		err = hci_check_conn_params_legacy(min, max, latency,
> +						   to_multiplier);
> +		if (!err) {
> +			/* latency is invalid, cap it to the max allowed */
> +			latency = min(499, (to_multiplier * 4 / max) - 1);
> +		}
> +	}
> +
> 	if (err)
> 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
> 	else

Regards

Marcel


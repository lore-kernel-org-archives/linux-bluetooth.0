Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1176C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiBIVJI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:09:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiBIVJI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 16:09:08 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA05C050CF8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 13:09:09 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E3F7CED2D;
        Wed,  9 Feb 2022 22:09:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v3 9/9] monitor: print quality report cmd
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220209092414.751642-7-josephsih@chromium.org>
Date:   Wed, 9 Feb 2022 22:09:07 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <289435E7-4B3D-415C-B13A-AF31D1BF87E8@holtmann.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
 <20220209092414.751642-7-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch prints the set quality command properly.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - This is a new patch that prints the set quality command.
> 
> monitor/packet.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 397000644..4dce2f681 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -12011,6 +12011,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
> 	{ 15, "Static Address"		},
> 	{ 16, "PHY Configuration"	},
> 	{ 17, "Wideband Speech"		},
> +	{ 18, "Quality Report"		},
> 	{ }
> };
> 
> @@ -13607,6 +13608,13 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
> 	print_field("Handle: %d", handle);
> }
> 
> +static void mgmt_set_quality_report_cmd(const void *data, uint16_t size)
> +{
> +	uint8_t action = *(uint8_t *)data;

please use get_u8(data).

> +
> +	print_field("Set Quality Report %u", action);
> +}
> +
> struct mgmt_data {
> 	uint16_t opcode;
> 	const char *str;
> @@ -13864,6 +13872,9 @@ static const struct mgmt_data mgmt_command_table[] = {
> 				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
> 									false,
> 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
> +	{ 0x0057, "Set Quality Report",
> +				mgmt_set_quality_report_cmd, 1, true,
> +				mgmt_null_rsp, 0, true },
> 	{ }
> };

We also have a few mgmt commands that miss decodes. If you have bandwidth, feel free to add these as well.

And we should have them also added to btmon --todo.

Regards

Marcel


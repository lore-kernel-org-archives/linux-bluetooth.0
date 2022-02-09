Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC1BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 21:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiBIVCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:02:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiBIVCe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 16:02:34 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77997C08C5F5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 13:02:34 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 605A9CED2D;
        Wed,  9 Feb 2022 22:02:33 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v3 2/9] lib: Add structures and constants for
 quality report event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220209092414.751642-2-josephsih@chromium.org>
Date:   Wed, 9 Feb 2022 22:02:32 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <91511B47-1A3B-41FD-9C02-D47666B4C091@holtmann.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
 <20220209092414.751642-2-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the new struct and constants to lib/mgmt.h.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
> 
> Changes in v2:
> - This is a new patch for adding the new struct and constants.
> 
> lib/mgmt.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 922a24367..db9a24cd6 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -1032,6 +1032,15 @@ struct mgmt_ev_adv_monitor_device_lost {
> 	struct mgmt_addr_info addr;
> } __packed;
> 
> +#define MGMT_EV_QUALITY_REPORT			0x0031
> +#define QUALITY_SPEC_AOSP_BQR			0x0

Just AOSP.

> +#define QUALITY_SPEC_INTEL_TELEMETRY		0x1

Just INTEL.

> +struct mgmt_ev_quality_report {
> +	uint8_t quality_spec;
> +	uint32_t data_len;
> +	uint8_t data[];
> +} __packed;
> +
> static const char *mgmt_op[] = {
> 	"<0x0000>",
> 	"Read Version",
> @@ -1172,6 +1181,7 @@ static const char *mgmt_ev[] = {
> 	"Controller Resume",
> 	"Advertisement Monitor Device Found",		/* 0x002f */
> 	"Advertisement Monitor Device Lost",
> +	"Bluetooth Quality Report",			/* 0x0031 */
> };
> 
> static const char *mgmt_status[] = {

as with the mgmt-api.txt changes, just “Quality Report” and combine command and event changes.

Regards

Marcel


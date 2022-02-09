Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61294C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 21:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBIVKO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:10:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiBIVKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 16:10:13 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD1FCC050CF8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 13:10:15 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 121D3CED2D;
        Wed,  9 Feb 2022 22:10:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v3 1/9] doc: Add Bluetooth quality report event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
Date:   Wed, 9 Feb 2022 22:10:13 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BFB91287-3DC5-46AB-B339-2598EC5FC96E@holtmann.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the Bluetooth quality report event in doc/mgmt-api.txt.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
> - Add 5 new patches (5/9 - 9/9) to enable the quality report
>  feature via MGMT_OP_SET_QUALITY_REPORT instead of through the
>  experimental features.
> 
> Changes in v2:
> - This is a new patch for adding the event in doc/mgmt-api.txt
> 
> doc/mgmt-api.txt | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..5a32091fa 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -4978,3 +4978,22 @@ Advertisement Monitor Device Lost Event
> 		2	LE Random
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Bluetooth Quality Report Event
> +==============================

so this is on me since I never realized this. You stuck the Bluetooth word in front of the event name since that is also what AOSP calls it. However in mgmt-api.txt we have never added Bluetooth to command or event naming since that is obvious. So lets shorten this and just use “Quality Report Event”.

> +
> +	Event code:		0x0031
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Quality_Spec (1 Octet)
> +				Report_Len (2 Octets)
> +				Report (0-65535 Octets)
> +
> +	This event carries the Bluetooth quality report sent by the
> +	controller.
> +
> +	Possible values for the Quality_Spec parameter:
> +		0	AOSP Bluetooth Quality Report Event
> +		1	Intel Telemetry Event
> +
> +	This event will be sent to all management sockets.
> — 

In addition, I prefer to have both command and event changes in a single patch.

Regards

Marcel




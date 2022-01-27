Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C08BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 20:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiA0UCH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:02:07 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48995 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiA0UCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:01 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id B3499CED25;
        Thu, 27 Jan 2022 21:01:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [BlueZ PATCH v2 1/4] doc: Add Bluetooth quality report event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220127101609.3646316-1-josephsih@chromium.org>
Date:   Thu, 27 Jan 2022 21:01:58 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        josephsih@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <F67144BA-E7CF-43B7-997C-576536BA5968@holtmann.org>
References: <20220127101609.3646316-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the Bluetooth quality report event in doc/mgmt-api.txt.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v2:
> - This is a new patch for adding the event in doc/mgmt-api.txt
> 
> doc/mgmt-api.txt | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..a0e71a732 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -4978,3 +4978,23 @@ Advertisement Monitor Device Lost Event
> 		2	LE Random
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Bluetooth Quality Report Event
> +==============================
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
> +		0	Not Available
> +		1	Intel Telemetry Event
> +		2	AOSP Bluetooth Quality Report Event

can we swap this around please:

		0	AOSP Bluetooth Quality Report Event
		1	Intel Telemetry Event

Regards

Marcel


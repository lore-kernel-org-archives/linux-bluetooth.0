Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 21:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiBIVEd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:04:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBIVEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 16:04:32 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 226D5C033255
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 13:04:35 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47E39CED2D;
        Wed,  9 Feb 2022 22:04:34 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v3 5/9] doc: Introduce the Set Quality Report
 Command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220209092414.751642-3-josephsih@chromium.org>
Date:   Wed, 9 Feb 2022 22:04:33 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        josephsih@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <4FDE7909-3225-4B58-B4D3-CE06DE073C51@holtmann.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
 <20220209092414.751642-3-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the Set Quality Report Command in doc/mgmt-api.txt.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v3:
> - This is a new patch that introduces the Set Quality Report
>  Command.
> 
> doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5a32091fa..4ac84d41b 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -332,6 +332,7 @@ Read Controller Information Command
> 		15	Static Address
> 		16	PHY Configuration
> 		17	Wideband Speech
> +		18	Quality Report
> 
> 	This command generates a Command Complete event on success or
> 	a Command Status event on failure.
> @@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
> 		15	Static Address
> 		16	PHY Configuration
> 		17	Wideband Speech
> +		18	Quality Report
> 
> 	The EIR_Data field contains information about class of device,
> 	local name and other values. Not all of them might be present. For
> @@ -3858,6 +3860,37 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> 				Invalid Parameters
> 
> 
> +Set Quality Report Command
> +==========================
> +
> +	Command Code:           0x0057
> +	Controller Index:       <controller id>
> +	Command Parameters:     Action (1 Octet)

	Quality_Report (1 Octet)

> +	Return Parameters:

	Current_Settings (4 Octets)

> +
> +	This command is used to enable and disable the controller's quality
> +	report feature.
> +
> +	This command requires to use a valid controller index. Otherwise,
> +	an "invalid index" status will be returned.
> +
> +	The parameter "action" can be either 0 to disable the feature or
> +	1 to enable the feature. For any values other than 0 and 1, an
> +	"invalid parameters" status will be returned.
> +
> +	If the driver does not indicate that the controller supports the
> +	quality report feature, a "not supported" status will be returned.
> +
> +	The command is sent to the controller to enable/disable the quality
> +	report feature. If the controller failed to execute the action, a
> +	"failed" status will be returned.
> +
> +	Possible errors:	Failed
> +				Invalid Index
> +				Invalid Parameters
> +				Not Supported
> +
> +

You might want to have the description a bit more in line with the others like Set Wideband Speech etc.

Regards

Marcel


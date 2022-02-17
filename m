Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD2BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 12:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiBQMNx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:13:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbiBQMNw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 07:13:52 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C4F9B18B3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 04:13:35 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7C6A7CECDD;
        Thu, 17 Feb 2022 13:13:34 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BlueZ PATCH v4 1/8] doc: Introduce the quality report command
 and event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
Date:   Thu, 17 Feb 2022 13:13:33 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, josephsih@google.com,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <666C5B97-A51C-48B9-AC91-0655C0D158B5@holtmann.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Add the MGMT quality report command and event in doc/mgmt-api.txt.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> Changes in v4:
> - Use "Quality Report Event" without the prefix "Bluetooth" word.
> - Combine both MGMT quality report command and event changes in a
>  single patch.
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
> doc/mgmt-api.txt | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 61 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..a494f5d7e 100644
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
> @@ -3858,6 +3860,46 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> 				Invalid Parameters
> 
> 
> +Set Quality Report Command
> +==========================
> +
> +	Command Code:		0x0057
> +	Controller Index:	<controller id>
> +	Command Parameters:	Action (1 Octet)

I remember mentioning that we should use Quality_Report instead of Action.

> +	Return Parameters:	Current_Settings (4 Octets)
> +
> +	This command is used to enable and disable the controller's quality
> +	report feature. The allowed values for the Action command parameter
> +	are 0x00 and 0x01. All other values will return Invalid Parameters.
> +
> +	The value 0x00 disables the Quality Report, and the value 0x01
> +	enables the Quality Report feature.
> +
> +	This command is only available for the controllers that support
> +	either AOSP Bluetooth quality report or Intel telemetry event.

The details below are interesting, but don’t have to be in this document. It is supported if the Supported_Settings indicate support for it.

> +	For a controller supporting the AOSP specification, it should call
> +	hci_set_aosp_capable() in its driver. The controller should also
> +	return version_supported v0.98 or higher in its Vendor-specific
> +	capabilities responding to the LE_Get_Vendor_Capabilities_Command.
> +	On the other hand, for a controller supporting Intel specification,
> +	it should set up the set_quality_report callback properly. The driver
> +	is responsible of setting up the quality report capability as
> +	described above; otherwise, a Not Supported status will be returned.
> +
> +	This command requires to use a valid controller index. Otherwise,
> +	an Invalid Index status will be returned.
> +
> +	The command is sent to the controller to enable/disable the quality
> +	report feature, and generates a Command Complete event on success.
> +	If the controller failed to execute the action, a Failed status will
> +	be returned.

Can this be used when powered off, is it remembered over power off/on cycles etc.

> +
> +	Possible errors:	Failed
> +				Invalid Index
> +				Invalid Parameters
> +				Not Supported
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4978,3 +5020,22 @@ Advertisement Monitor Device Lost Event
> 		2	LE Random
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Quality Report Event
> +====================
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

Regards

Marcel


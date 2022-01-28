Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77747C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiA1N2w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:28:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51966 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiA1N2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 08:28:52 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2CC2DCED37;
        Fri, 28 Jan 2022 14:28:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [BlueZ PATCH v2 1/4] doc: Add Bluetooth quality report event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220127101609.3646316-1-josephsih@chromium.org>
Date:   Fri, 28 Jan 2022 14:28:50 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <6A836EC1-7D2C-4638-8069-C3DF2A2A764C@holtmann.org>
References: <20220127101609.3646316-1-josephsih@chromium.org>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jospeh,

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
> +
> +	This event will be sent to all management sockets.
> -- 

and since you are now adding a mgmt event, we can no longer use debug setting to enable this feature.

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4494..ff7d81af2f90 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,6 +332,7 @@ Read Controller Information Command
                15      Static Address
                16      PHY Configuration
                17      Wideband Speech
+               18      Quality Report
 
        This command generates a Command Complete event on success or
        a Command Status event on failure.
@@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
                15      Static Address
                16      PHY Configuration
                17      Wideband Speech
+               18      Quality Report
 
        The EIR_Data field contains information about class of device,
        local name and other values. Not all of them might be present. For
@@ -3858,6 +3860,15 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
                                Invalid Parameters
 
 
+Set Quality Report Command
+==========================
+
+       Command Code:           0x0057
+       Controller Index:       <controller id>
+       Command Parameters:     Quality_Report (1 Octet)
+       Return Parameters:      Current_Settings (4 Octets)
+
+
 Command Complete Event
 ======================


Please add a Set Quality Report command for this as well. You need to fill in the description, but you get the idea.

Regards

Marcel


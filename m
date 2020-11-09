Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C0C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C86E20789
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIMtt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:49:49 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47946 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMts (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 07:49:48 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id F3DB3CECC6;
        Mon,  9 Nov 2020 13:56:23 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [Bluez PATCH v6 03/10] doc/mgmt-api: Update controller
 capabilities MGMT command in mgmt-api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201029160317.Bluez.v6.3.Iabfcf7ec8ac293130a7d903ee8094414256799b3@changeid>
Date:   Mon, 9 Nov 2020 13:49:14 +0100
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <263DCED1-D5D0-4ABD-A6C9-5A4ACA45458E@holtmann.org>
References: <20201029230623.3630069-1-danielwinkler@google.com>
 <20201029160317.Bluez.v6.3.Iabfcf7ec8ac293130a7d903ee8094414256799b3@changeid>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> This patch changes Read Security Info MGMT to be called Read Controller
> Capabilities Command
> 
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> - mgmt-api: Move Controller Capabilities MGMT doc into new patch
> - mgmt-api: Tx Power range put into single capabilities entry
> 
> Changes in v3: None
> Changes in v2: None
> 
> doc/mgmt-api.txt | 21 +++++++++++++++------
> 1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 7c899a8fe..1aa43d6c3 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3110,19 +3110,19 @@ Set Wideband Speech Command
> 				Invalid Index
> 
> 
> -Read Security Information Command
> -=================================
> +Read Controller Capabilities Command
> +====================================
> 
> 	Command Code:		0x0048
> 	Controller Index:	<controller id>
> 	Command Parameters:
> -	Return Parameters:	Security_Data_Length (2 Octets)
> -				Security_Data (0-65535 Octets)
> +	Return Parameters:	Capabilities_Data_Length (2 Octets)
> +				Capabilities_Data (0-65535 Octets)
> 
> -	This command is used to retrieve the supported security features
> +	This command is used to retrieve the supported capabilities
> 	by the controller or the host stack.
> 
> -	The Security_Data_Length and Security_Data parameters provide
> +	The Capabilities_Data_Length and Capabilities_Data parameters provide
> 	a list of security settings, features and information. It uses
> 	the same format as EIR_Data, but with the namespace defined here.
> 
> @@ -3131,6 +3131,7 @@ Read Security Information Command
> 		0x01		Flags
> 		0x02		Max Encryption Key Size (BR/EDR)
> 		0x03		Max Encryption Key Size (LE)
> +		0x04		Supported Tx Power (LE)

make this “Supported Min/Max TX Power”. Otherwise looks good and ready for Luiz to apply.

Regards

Marcel


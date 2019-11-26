Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC08C432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890762080F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 18:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKZSkf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:40:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57021 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKZSkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 13:40:35 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id BD4D4CED00;
        Tue, 26 Nov 2019 19:49:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Proposal for key blacklisting via mgmt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_WoH+CMAinEtOyP0Qts6U=zJqC0uYHkqh3dSyGrcziY=w@mail.gmail.com>
Date:   Tue, 26 Nov 2019 19:40:32 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <26EAF78A-CDDD-4053-8B02-23A003A48A0A@holtmann.org>
References: <D3DDA56B-7CEA-46EE-96AB-D78280B49921@holtmann.org>
 <CALWDO_WoH+CMAinEtOyP0Qts6U=zJqC0uYHkqh3dSyGrcziY=w@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Here is a counter proposal which also aligns with the command op-code miss alignment patch sent earlier.
> 
> From 26d156f757c24d9e1313f2d14d528e219433b2bf Mon Sep 17 00:00:00 2001
> From: Alain Michaud <alainm@chromium.org>
> Date: Tue, 26 Nov 2019 18:19:36 +0000
> Subject: [PATCH] Blocked key mgmt Api definition
> 
> ---
>  doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 0d11aa035..7c77927a2 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3013,6 +3013,39 @@ Set PHY Configuration Command
>  	Possible errors:	Invalid Parameters
>  	Invalid Index
> 
> +Load Blocked Keys Command
> +===========================
> +
> +	Command Code:	0x0046
> +	Controller Index:	<controller id>
> +	Command Parameters:	Key_Count (2 Octets)
> +	Key1 {
> +	Key_Type (1 Octet)
> +	Value (16 Octets)
> +	}
> +	Key2 { }
> +	...
> +	Return Parameters:
> +
> +	This command is used to feed the kernel a list of keys that
> +	are known to be vulnerable.
> +
> +	Currently defined Key_Type values are:
> +
> +	0x00	Link Key (BR/EDR)
> +	0x01	Long Term Key (LE)
> +	0x02	Identity Resolving Key (LE)
> +
> +	This command can be used at anypoint to add to the list of blocked keys.  Any connections that
> +	are attempting to use the keys will be terminated. If a device tries to distribute the keys during
> +	pairing, pairing will fail.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +	Invalid Index
> +

I would propose you utilize git-format-patch and git-send-email to ensure that we receive patches in ASCII format that I can apply utilizing git-am.

Regards

Marcel


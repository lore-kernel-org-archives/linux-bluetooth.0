Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECEC61A00
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 07:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhCXHzg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:55:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58589 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCXHzZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 03:55:25 -0400
Received: from mac-pro.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8652DCECF8;
        Wed, 24 Mar 2021 09:03:00 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC PATCH v1] doc/mgmt-api - Return connection direction in
 Device Connected Event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210323145555.RFC.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Date:   Wed, 24 Mar 2021 08:55:21 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E266F46F-8682-4D1C-A191-345715E1DE34@holtmann.org>
References: <20210323145555.RFC.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
To:     Yu Liu <yudiliu@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

> When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
> space we will set the flags to tell if the established connection is
> outbound or not. This is useful for the user space to log better metrics
> and error messages.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v1:
> - Initial change
> 
> doc/mgmt-api.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cab1fffc5..534272045 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -4085,7 +4085,7 @@ Device Connected Event
> 	start using its identity.
> 
> 	The following bits are defined for the Flags parameter:
> -		0	Reserved (not in use)
> +		0	Outbound Connection
> 		1	Legacy Pairing
> 		2	Reserved (not in use)

the reserved ones are there to keep in sync with Device Found. So please use the next free one (and reserve it for Device Found).

Also I am not fully in favor of “Outbound Connection”. I rather use the term “Central” in case we are the Central / Master of a connection. Now that however gets into trouble with BR/EDR since there you can switch roles. So maybe “Initiated Connection” is an option.

Regards

Marcel


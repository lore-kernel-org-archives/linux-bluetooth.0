Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B00C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 07:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAE861A38
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 07:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCZHli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:41:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49134 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZHlM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 03:41:12 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id D8594CEC82;
        Fri, 26 Mar 2021 08:48:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC PATCH v2] doc/mgmt-api - Return connection direction in
 Device Connected Event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210324115840.RFC.v2.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Date:   Fri, 26 Mar 2021 08:41:11 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6BF2252B-E7BE-42BF-9C71-D7A08AFC5C10@holtmann.org>
References: <20210324115840.RFC.v2.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
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
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
> 
> Changes in v2:
> - Use next free bit
> 
> Changes in v1:
> - Initial change
> 
> doc/mgmt-api.txt | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cab1fffc5..98552e761 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -4088,6 +4088,7 @@ Device Connected Event
> 		0	Reserved (not in use)
> 		1	Legacy Pairing
> 		2	Reserved (not in use)
> +		3	Initiated Connection

please also mark it reserved in Device Found event.

Regards

Marcel


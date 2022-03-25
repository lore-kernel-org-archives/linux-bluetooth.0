Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE9EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359440AbiCYPCL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiCYPCJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 11:02:09 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 793AF91AF4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 08:00:34 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 600F7CECE4;
        Fri, 25 Mar 2022 16:00:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ v4 3/9] mgmt: Introduce mgmt_set_verbose
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220323224003.3736525-4-luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 16:00:32 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EDAE076A-F5CC-4829-9DD1-40DCE3FB536A@holtmann.org>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
 <20220323224003.3736525-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces mgmt_set_verbose which can be used to enable printing
> the the likes hexdump of packets, by default it is disabled since in
> most cases the hexdump is not very useful and there are better tools
> to collect the hexdumo like btmon.
> ---
> src/shared/mgmt.c | 24 ++++++++++++++++++++----
> src/shared/mgmt.h |  1 +
> 2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index c7e6a6c1d..cf518cc2b 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -50,6 +50,7 @@ struct mgmt {
> 	mgmt_debug_func_t debug_callback;
> 	mgmt_destroy_func_t debug_destroy;
> 	void *debug_data;
> +	bool verbose;
> };
> 
> struct mgmt_request {
> @@ -192,6 +193,15 @@ static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
> 	va_end(ap);
> }
> 
> +static void mgmt_hexdump(struct mgmt *mgmt, char dir, const void *data,
> +							size_t len)
> +{
> +	if (!mgmt->verbose)
> +		return;
> +
> +	util_hexdump(dir, data, len, mgmt->debug_callback, mgmt->debug_data);
> +}
> +

this is stupid, lets just remove the support for hexdump altogether here. This code was written when mgmt tracing via btmon was not available, but since it is now, there is really no point.

Regards

Marcel


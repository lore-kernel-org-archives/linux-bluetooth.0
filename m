Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 15:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354107AbiCYPFy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiCYPFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 11:05:53 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1FC690CFA
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 08:04:18 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 88542CECE4;
        Fri, 25 Mar 2022 16:04:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ v4 4/9] adapter: Don't use DBG in mgmt_debug
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220323224003.3736525-5-luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 16:04:17 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DBCDA834-B13F-46E2-A693-B9F44F8634AD@holtmann.org>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
 <20220323224003.3736525-5-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> mgmt_debug callback is used to print debug strings from mgmt instances
> which includes the file and function names so using DBG would add yet
> another set of file and function prefixes which makes the logs
> confusing.
> ---
> src/adapter.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 97ce26f8e..9f003346d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -10327,9 +10327,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
> 
> static void mgmt_debug(const char *str, void *user_data)
> {
> -	const char *prefix = user_data;
> -
> -	info("%s%s", prefix, str);
> +	DBG_IDX(0xffff, "%s", str);
> }
> 
> int adapter_init(void)
> @@ -10342,8 +10340,7 @@ int adapter_init(void)
> 		return -EIO;
> 	}
> 
> -	if (getenv("MGMT_DEBUG"))
> -		mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
> +	mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);
> 
> 	DBG("sending read version command");

oh what now. If you touch this, then please do it in a way that you print it properly to the btmon traces as well with the correct index.

Look, the MGMT_DEBUG thing is meant for debugging aid. That is why it enabled tracing. If you want to print errors or warning that otherwise are hidden, just print them. And make sure they end up in btmon as well. This is all hacking around the real solution. It is a bandaid for a bandaid.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 10:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiCWKjC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCWKjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 06:39:01 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B05315BE55
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 03:37:31 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7A3ACED31;
        Wed, 23 Mar 2022 11:37:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ v2 4/9] adapter: Don't use DBG in mgmt_debug
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220323000654.3157833-4-luiz.dentz@gmail.com>
Date:   Wed, 23 Mar 2022 11:37:30 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DE87AE95-85DD-4732-8D49-F6E212F836B6@holtmann.org>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
 <20220323000654.3157833-4-luiz.dentz@gmail.com>
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
> src/adapter.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 97ce26f8e..6680c5410 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -10327,9 +10327,8 @@ static void read_version_complete(uint8_t status, uint16_t length,
> 
> static void mgmt_debug(const char *str, void *user_data)
> {
> -	const char *prefix = user_data;
> -
> -	info("%s%s", prefix, str);
> +	if (DBG_IS_ENABLED())
> +		btd_debug(0xffff, "%s", str);
> }
> 
> int adapter_init(void)
> @@ -10342,8 +10341,7 @@ int adapter_init(void)
> 		return -EIO;
> 	}
> 
> -	if (getenv("MGMT_DEBUG"))
> -		mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
> +	mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);

oh no. This is crazy. Please re-think this and what computational overhead you are introducing.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E352C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiKMPzK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMPzJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 10:55:09 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F1DF58
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:55:06 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4N9H865pXmz9sTV;
        Sun, 13 Nov 2022 16:55:02 +0100 (CET)
Message-ID: <02bf340b-c908-6ee8-ca78-4203b965f3b5@dressler.it>
Date:   Sun, 13 Nov 2022 16:54:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH BlueZ v7 6/6] adapter: Remove experimental flag for
 PowerState
To:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
References: <20220901110719.176944-1-hadess@hadess.net>
 <20220901110719.176944-6-hadess@hadess.net>
Content-Language: en-US
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <jonas@dressler.it>
In-Reply-To: <20220901110719.176944-6-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,

Can we please apply this one, too? The property being experimental means distros
need to downstream patch BlueZ for the feature to work, I'm not sure all packagers
are aware of that.

FWIW, I can confirm the feature in gnome-shell works after removing the flag!

Cheers,
Jonas

On 9/1/22 13:07, Bastien Nocera wrote:
> Now that the feature has been tested, that the API is deemed adequate
> and the reliability sufficient.
> ---
>   src/adapter.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 8fb2acdc8..841096d7f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3864,8 +3864,7 @@ static const GDBusPropertyTable adapter_properties[] = {
>   	{ "Alias", "s", property_get_alias, property_set_alias },
>   	{ "Class", "u", property_get_class },
>   	{ "Powered", "b", property_get_powered, property_set_powered },
> -	{ "PowerState", "s", property_get_power_state, NULL, NULL,
> -			     G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +	{ "PowerState", "s", property_get_power_state },
>   	{ "Discoverable", "b", property_get_discoverable,
>   					property_set_discoverable },
>   	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,


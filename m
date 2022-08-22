Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC17C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 06:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiHVGQE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiHVGQD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 02:16:03 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190827171
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 23:16:00 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeccb.dynamic.kabel-deutschland.de [95.90.236.203])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3744D61EA192C;
        Mon, 22 Aug 2022 08:15:58 +0200 (CEST)
Message-ID: <f9fd47a4-e5fc-5640-de71-dee1d52da2a8@molgen.mpg.de>
Date:   Mon, 22 Aug 2022 08:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT
 error
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Archie,


Thank you for the patch.


Am 22.08.22 um 06:53 schrieb Archie Pusaka:
> From: Archie Pusaka <apusaka@chromium.org>

I think the tag in the email subject needs to be [PATCH BlueZ] to be 
detected by the build bot.

> We set the pending settings flag when sending MGMT_SETTING_*
> commands to the MGMT layer and clear them when receiving success
> reply, but we don't clear them when receiving error reply. This
> might cause a setting to be stuck in pending state.

Were you able to reproduce a problem on real hardware?

> Therefore, also clear the pending flag when receiving error.
> Furthermore, this patch also postpone setting the pending flag

postpone*s*

> until we queue the MGMT command in order to avoid setting it too
> soon but we return early.

Maybe add a comment, that how you tested this?

> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> 
> ---
> 
>   src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 8 deletions(-)

[…]


Kind regards,

Paul

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73081C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 12:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiD0Mwe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiD0Mwb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 08:52:31 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B95402BFB47;
        Wed, 27 Apr 2022 05:49:14 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fbd8.dip0.t-ipconnect.de [79.249.251.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id B5B50CECF1;
        Wed, 27 Apr 2022 14:49:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and
 config files
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220427063504.384540-1-juergh@protonmail.com>
Date:   Wed, 27 Apr 2022 14:49:13 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <7E038C77-771A-415D-B963-128EB5DD9D48@holtmann.org>
References: <20220427063504.384540-1-juergh@protonmail.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Juerg,

> The ath3k driver loads patch and configuration files so add MODULE_FIRMWARE
> macros to povide that information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 88262d3a9392..56e9a64177ae 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
> MODULE_VERSION(VERSION);
> MODULE_LICENSE("GPL");
> MODULE_FIRMWARE(ATH3K_FIRMWARE);
> +MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
> +MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");

since when do we allow GLOB pattern matching here?

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 12:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiGMMYX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiGMMYX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 08:24:23 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D077A5E;
        Wed, 13 Jul 2022 05:24:17 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36A1661EA1933;
        Wed, 13 Jul 2022 14:24:15 +0200 (CEST)
Message-ID: <63317af9-22c8-b398-6e1f-10fbc441ef60@molgen.mpg.de>
Date:   Wed, 13 Jul 2022 14:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 1/5] Bluetooth: btusb: Add the support ID for Realtek
 RTL8852C
To:     Hilda Wu <hildawu@realtek.com>
References: <20220713075318.18176-1-hildawu@realtek.com>
 <20220713075318.18176-2-hildawu@realtek.com>
Content-Language: en-US
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220713075318.18176-2-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Hilda,


Thank you for the patches. As all five have the same commit message 
summary, maybe add the IDs to the summary to? Maybe:

> Bluetooth: btusb: Add Realtek RTL8552 id 0x04CA:0x4007


Kind regards,

Paul

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E054C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 10:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiI3KQI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiI3KQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 06:16:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE55153492
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:16:03 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C5AC61EA1929;
        Fri, 30 Sep 2022 12:16:01 +0200 (CEST)
Message-ID: <b9478f7c-c11f-5f67-860a-32a4dc86beff@molgen.mpg.de>
Date:   Fri, 30 Sep 2022 12:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Message from the future (wrong date) (was: [PATCH 1/3]
 audio/transport: seprate a2dp and bap transport to update volume)
Content-Language: en-US
To:     Sathish Narasimman <sathish.narasimman@intel.com>
References: <20220930184954.108937-1-sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220930184954.108937-1-sathish.narasimman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Sathish,


Thank you for your patches.


Am 30.09.22 um 20:49 schrieb Sathish Narasimman:

[…]

It looks like the clock on your system is incorrectly configured.

     Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
       by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2022 02:58:50 -0700
     […]
     Date:   Sat,  1 Oct 2022 00:19:52 +0530

Could you please fix that?

Also there is a typo in the summary/title: seprate → separate


Kind regards,

Paul

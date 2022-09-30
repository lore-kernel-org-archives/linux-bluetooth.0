Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 11:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiI3L0d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3L0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:07 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C3ADA6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 04:18:06 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6A14661EA1929;
        Fri, 30 Sep 2022 13:18:05 +0200 (CEST)
Message-ID: <2f0ce0d2-3739-8b44-aa1a-bad7000cdefa@molgen.mpg.de>
Date:   Fri, 30 Sep 2022 13:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] audio/transport: seperate a2dp and bap transport to
 update volume
Content-Language: en-US
To:     Sathish Narasimman <sathish.narasimman@intel.com>
References: <20220930104523.2572-1-sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220930104523.2572-1-sathish.narasimman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Sathish,


Am 30.09.22 um 12:45 schrieb Sathish Narasimman:

[…]

In the summary/title it should be sep*a*rate.

Please add a version to the tags, with `git format-patch --reroll-count 
X`, and add a short description after `---`, what changed between the 
versions.


Kind regards,

Paul

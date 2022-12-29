Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6214C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiL2MWU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2MWR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:22:17 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48E1208B
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:22:15 -0800 (PST)
Received: from [192.168.0.2] (ip5f5ae935.dynamic.kabel-deutschland.de [95.90.233.53])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5DE5860027FC5;
        Thu, 29 Dec 2022 13:22:14 +0100 (CET)
Message-ID: <20aebdae-8780-40c0-ae6c-3a67fe46cb60@molgen.mpg.de>
Date:   Thu, 29 Dec 2022 13:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH BlueZ v2 0/6] To add support for Metadata, CID, VID
Content-Language: en-US
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     Abhay Maheta <mabhay125@gmail.com>, linux-bluetooth@vger.kernel.org
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Abhay,


Thank you for your patches.


Am 29.12.22 um 13:28 schrieb Abhay Maheta:

[…]

Just a note, that your system time is configured incorrectly and set to 
the future.

     Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
       by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:09:48 -0800
     […]
     Date:   Thu, 29 Dec 2022 17:58:17 +0530

It’d be great, if you fixed that, as it messes up the ordering in the inbox.


Kind regards,

Paul

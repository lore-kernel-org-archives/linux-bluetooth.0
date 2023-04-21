Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E8C77B78
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 23:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjDUXRW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 19:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjDUXRU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 19:17:20 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 16:17:19 PDT
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net (p3plsmtpa09-02.prod.phx3.secureserver.net [173.201.193.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE812123
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 16:17:19 -0700 (PDT)
Received: from [192.168.0.58] ([70.112.164.231])
        by :SMTPAUTH: with ESMTPSA
        id pzy2pbAZZlzzNpzy3pOTMs; Fri, 21 Apr 2023 16:15:04 -0700
X-CMAE-Analysis: v=2.4 cv=BdoekJh2 c=1 sm=1 tr=0 ts=644318f8
 a=S3BSAMYkHO6g4MQ2VxJkNg==:117 a=S3BSAMYkHO6g4MQ2VxJkNg==:17
 a=IkcTkHD0fZMA:10 a=XHDi4TBjApxwP7wrQroA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: rg@braneaudio.com
Message-ID: <733a8933-008a-8394-4564-71e49c3a4059@braneaudio.com>
Date:   Fri, 21 Apr 2023 18:15:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Richard Greer <rg@braneaudio.com>
Subject: Is AVCTP Version Really 1.3?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKXM0rOcs7o3r8Q2BmG198ztc/W1fabYM++SZmruREmtYOz4mLhJu93Bj1DQq5ZXLySQQGJn2/NBuDBdX8eF8gXSNxY3BOVfwDFN3ASfJLVvMhNN6wzp
 /aj8jtcS92uNFzyrfVmuzAUDVlqNB7caPZCZl1TRfsfqrYFRbcpMnrNyLFpo1bqqYm1WXTa0ZEN24Db5ZO9iGX4U+R9KbSkg5VI=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I will start by saying that I am not a Bluetooth expert, but just getting started on Bluetooth development.

In looking at BlueZ 5.66, it seems that the version of AVCTP being reported is 1.3 (in avrcp_ct_record() in profiles/audio/avrcp.c) which corresponded with what is in doc/supported-features.txt (which looks like it was last updated several years ago).

On the BlueZ website there is an entry from 21 Aug, 2014 titled "Bluetooth 4.1 qualification for Tizen BlueZ" that says it was using AVCTP 1.4.

AVCTP version 1.3 was deprecated in July, 2013 and officially withdrawn on 1 Feb, 2023.

If I were to start working on a product that was going to have Bluetooth in it, I could not get it certified with AVCTP 1.3.  So, I was just sort of hoping that it was a version reporting issue (due to the Tizen BlueZ statement above about it using 1.4 8+ years ago) and not something that still needs to be developed.

Anyhow, if someone more familiar with Bluetooth on Linux can explain what is up with the AVCTP version, that would be greatly appreciated.


Thanks in advance,

Richard Greer

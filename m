Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3DC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 07:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjDSHMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDSHMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 03:12:31 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A640DB
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 00:12:29 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae81a.dynamic.kabel-deutschland.de [95.90.232.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AB53B61E4052B;
        Wed, 19 Apr 2023 09:12:26 +0200 (CEST)
Message-ID: <c11be905-10ef-c778-1bf2-bd9629729b12@molgen.mpg.de>
Date:   Wed, 19 Apr 2023 09:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH BlueZ v2] obexd: support to reply folder name to store
 file
Content-Language: en-US
To:     aarongt.shen@gmail.com
References: <20230419030742.6123-1-aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230419030742.6123-1-aarongt.shen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Aaron,


Thank you for your patch.

Am 19.04.23 um 05:07 schrieb Aaron_shen:

[…]

One cosmetic remark: Your name is shown as Aaron_shen. More common is 
probably Aaron Shen? I think you can improve that with:

     $ git config --global user.name "Aaron Shen"
     $ git commit --amend --author="Aaron Shen <aarongt.shen@gmail.com>"

Then you can send v3.


Kind regards,

Paul

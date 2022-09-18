Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7632C32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIRHqY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRHqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 03:46:23 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D32528A
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 00:46:21 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef17.dynamic.kabel-deutschland.de [95.90.239.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5ECC761EA1929;
        Sun, 18 Sep 2022 09:46:20 +0200 (CEST)
Message-ID: <4e39349e-fc2f-f245-9a8c-56c59121e284@molgen.mpg.de>
Date:   Sun, 18 Sep 2022 09:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
 <1ace324d-f2ac-f59c-3d21-8d4ebe2fb148@molgen.mpg.de>
 <TY3P286MB2611180EF41ADA1FB154F5EF984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <TY3P286MB2611180EF41ADA1FB154F5EF984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Shengyu,


Am 18.09.22 um 09:13 schrieb Shengyu Qu:
> Thanks for your advice. Driver version is 1.0.0.1205 (Windows 10 driver).
> Should I resend a patch with modified commit message?

Yes, a v2 would be wonderful.

     git commit --amend
     git format-patch -v 2 …


Kind regards,

Paul

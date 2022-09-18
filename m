Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79FC32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIRGxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRGw5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 02:52:57 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648CB26135
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Sep 2022 23:52:56 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef17.dynamic.kabel-deutschland.de [95.90.239.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C114961EA1929;
        Sun, 18 Sep 2022 08:52:53 +0200 (CEST)
Message-ID: <1ace324d-f2ac-f59c-3d21-8d4ebe2fb148@molgen.mpg.de>
Date:   Sun, 18 Sep 2022 08:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855
To:     Shengyu Qu <wiagn233@outlook.com>
References: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Shengyu,


Thank you for the patch. Two nits below.

Am 18.09.22 um 08:38 schrieb Shengyu Qu:
> Add IDs to usb_device_id table for WCN6855.
> IDs are extracted from Windows driver of Lenovo
> Thinkpad T14 Gen 2.

Please reflow for 75 characters per line, and maybe don’t add a line 
break, or add a blnak between paragraphs.

Please add the Microsoft Windows driver version, and maybe the location 
(Internet Archive URL) for reference.

[…]


Kind regards,

Paul

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8DC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCFPNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 10:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCFPNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 10:13:34 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42E17CD4
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 07:13:32 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D206460027689;
        Mon,  6 Mar 2023 16:13:28 +0100 (CET)
Message-ID: <af88f32a-9187-1cd5-d88d-ebd25c45a6ef@molgen.mpg.de>
Date:   Mon, 6 Mar 2023 16:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH BlueZ] btmon: Fix decoding truncated data
Content-Language: en-US
To:     =?UTF-8?Q?=c5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
References: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Łukasz,


Thank you for your patch.

Am 06.03.23 um 15:52 schrieb Łukasz Rymanowski:
> Some platforms use different filtering and for this purpose,
> some of the ACL/SCO/ISO/SDP data are truncated.

(… is truncated.)

It’d be great if you listed an example to reproduce it.

> In such a case, included lenght is smaller the original size.

•   leng*th*
•   … smaller than the original size.

> Without this fix, btmon stops working after first truncated packet.
> ---
>   src/shared/btsnoop.c | 2 +-
>   tools/btsnoop.c      | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

[…]


Kind regards,

Paul

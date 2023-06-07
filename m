Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F784C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 12:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbjFGM0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbjFGM0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 08:26:09 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA11BE2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:26:00 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 98F5B61DFA90A;
        Wed,  7 Jun 2023 14:24:39 +0200 (CEST)
Message-ID: <3c218601-d21e-7a51-c215-e39e4f0c49c1@molgen.mpg.de>
Date:   Wed, 7 Jun 2023 14:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH BlueZ v2 1/2] Added initial code for handling VOCS
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
References: <20230607121342.6136-1-nitin.jadhav@nxp.com>
 <20230607121342.6136-2-nitin.jadhav@nxp.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230607121342.6136-2-nitin.jadhav@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Nitin,


Thank you for your patch.

Am 07.06.23 um 14:13 schrieb Nitin Jadhav:

It’d be great if you used imperative mood in the commit message 
summary/title. Maybe:

Add initial VOCS code

> This adds implementation for VOCS service and characteristics

Please document the datasheet name and version, you used to write the code.

If you summarized the implementation, and also documented how you tested 
this, that’d be great.

> ---
> v2: Corrected prefixs and cosmetic changes (Luiz Augusto von Dentz)
> ---
>   lib/uuid.h       |   5 +
>   src/shared/vcp.c | 537 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 542 insertions(+)

[…]


Kind regards,

Paul

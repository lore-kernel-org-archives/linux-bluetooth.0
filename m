Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B34CCA482
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jul 2022 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiGOHec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiGOHeG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jul 2022 03:34:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225BE002;
        Fri, 15 Jul 2022 00:34:03 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb39.dynamic.kabel-deutschland.de [95.90.235.57])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A5A9B61EA192C;
        Fri, 15 Jul 2022 09:34:00 +0200 (CEST)
Message-ID: <afbf4b73-29b9-1bca-e5f5-85b7bfdcf568@molgen.mpg.de>
Date:   Fri, 15 Jul 2022 09:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Remove redundant func definition
Content-Language: en-US
To:     Zijun Hu <quic_zijuhu@quicinc.com>
References: <1657858487-29052-1-git-send-email-quic_zijuhu@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, luiz.von.dentz@intel.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1657858487-29052-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Zijun,


Thank you for the patch.

Am 15.07.22 um 06:14 schrieb Zijun Hu:
> both hci_request.c and hci_sync.c have the same definition
> for disconnected_accept_list_entries(), so remove a redundant
> copy.

Please use 75 characters per line for Linux commit message bodies. That 
way, only two instead of three lines are needed.
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> v1->v2
> 	-remove the func copy within hci_request.c instead of hci_sync.c
>   net/bluetooth/hci_request.c | 18 ------------------
>   net/bluetooth/hci_request.h |  2 ++
>   net/bluetooth/hci_sync.c    |  2 +-
>   3 files changed, 3 insertions(+), 19 deletions(-)

[…]


Kind regards,

Paul

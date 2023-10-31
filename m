Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56381C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 12:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJaMui (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjJaMuh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 08:50:37 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D29BD;
        Tue, 31 Oct 2023 05:50:34 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SKVNh3YBSz9srd;
        Tue, 31 Oct 2023 13:50:28 +0100 (CET)
Message-ID: <ddd10375-ac56-4fed-821f-546f0642ccab@v0yd.nl>
Date:   Tue, 31 Oct 2023 13:50:24 +0100
MIME-Version: 1.0
To:     josephsih@chromium.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, davem@davemloft.net,
        edumazet@google.com, johan.hedberg@gmail.com, josephsih@google.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        pali@kernel.org
References: <20220526112135.2486883-1-josephsih@chromium.org>
Subject: Re: [PATCH v6 1/5] Bluetooth: mgmt: add MGMT_OP_SET_QUALITY_REPORT
 for quality report
Content-Language: en-US
From:   =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <20220526112135.2486883-1-josephsih@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

gentle ping about this one, are you still planning to propose a v7 here?

Regards,
Jonas

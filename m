Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991ACC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C98A610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbhHSOxJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:53:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45577 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhHSOxJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 10:53:09 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 04737CED16;
        Thu, 19 Aug 2021 16:52:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: mgmt: Pessimize compile-time bounds-check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210818043912.1466447-1-keescook@chromium.org>
Date:   Thu, 19 Aug 2021 16:52:30 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <73F86183-989F-439F-9A92-B186C4E3306E@holtmann.org>
References: <20210818043912.1466447-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kees,

> After gaining __alloc_size hints, GCC thinks it can reach a memcpy()
> with eir_len == 0 (since it can't see into the rewrite of status).
> Instead, check eir_len == 0, avoiding this future warning:
> 
> In function 'eir_append_data',
>    inlined from 'read_local_oob_ext_data_complete' at net/bluetooth/mgmt.c:7210:12:
> ./include/linux/fortify-string.h:54:29: warning: '__builtin_memcpy' offset 5 is out of the bounds [0, 3] [-Warray-bounds]
> ...
> net/bluetooth/hci_request.h:133:2: note: in expansion of macro 'memcpy'
>  133 |  memcpy(&eir[eir_len], data, data_len);
>      |  ^~~~~~
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


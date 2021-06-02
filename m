Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F74C4708F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C93613D7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFBUQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:16:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43763 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBUQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 16:16:35 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id B3966CED0B;
        Wed,  2 Jun 2021 22:22:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH net-next] Bluetooth: Fix spelling mistakes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210602065458.105041-1-zhengyongjun3@huawei.com>
Date:   Wed, 2 Jun 2021 22:14:50 +0200
Cc:     "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BB77A0CF-83CE-407E-BFCB-8367091434B9@holtmann.org>
References: <20210602065458.105041-1-zhengyongjun3@huawei.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zheng,

> Fix some spelling mistakes in comments:
> udpate  ==> update
> retreive  ==> retrieve
> accidentially  ==> accidentally
> correspondig  ==> corresponding
> adddress  ==> address
> estabilish  ==> establish
> commplete  ==> complete
> Unkown  ==> Unknown
> triggerd  ==> triggered
> transtion  ==> transition
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
> net/bluetooth/hci_conn.c  | 2 +-
> net/bluetooth/hci_core.c  | 8 ++++----
> net/bluetooth/hci_event.c | 2 +-
> net/bluetooth/hci_sock.c  | 6 +++---
> net/bluetooth/mgmt.c      | 2 +-
> net/bluetooth/smp.c       | 6 +++---
> 6 files changed, 13 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


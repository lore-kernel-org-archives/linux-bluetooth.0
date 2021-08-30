Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3934FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 21:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1921660FA0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 21:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhH3VSo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:18:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55025 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhH3VSo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 17:18:44 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BC8CCECC7;
        Mon, 30 Aug 2021 23:17:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix using RPA when address has been
 resolved
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210830205537.118960-2-luiz.dentz@gmail.com>
Date:   Mon, 30 Aug 2021 23:17:48 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4D30495D-AF7D-418F-BA15-8DD7D2BC97EA@holtmann.org>
References: <20210830205537.118960-1-luiz.dentz@gmail.com>
 <20210830205537.118960-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When connecting to a device using an RPA if the address has been
> resolved by the controller (types 0x02 and 0x03) the identity address
> shall be used as the actual RPA in the advertisement won't be visible
> to the host.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++--
> net/bluetooth/hci_conn.c         | 33 ++++++++++++++++++--------------
> net/bluetooth/hci_event.c        | 33 +++++++++++++++++++-------------
> net/bluetooth/l2cap_core.c       |  2 +-
> 4 files changed, 43 insertions(+), 30 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


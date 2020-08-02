Return-Path: <SRS0=6lUD=BM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4F7C433E1
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 18:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3371E20738
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 18:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHBSC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:02:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33877 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSCz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Aug 2020 14:02:55 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id E6FDECED31;
        Sun,  2 Aug 2020 20:12:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_h5: Remove ignored flag
 HCI_UART_RESET_ON_INIT
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200801162956.22610-1-samuel@sholland.org>
Date:   Sun, 2 Aug 2020 20:02:54 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9854BD61-4A65-4F4F-AAB4-138C34B13312@holtmann.org>
References: <20200801162956.22610-1-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Samuel,

> Since commit cba736465e5c ("Bluetooth: hci_serdev: Remove setting of
> HCI_QUIRK_RESET_ON_CLOSE."), this flag is ignored for hci_serdev users,
> so let's remove setting it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> drivers/bluetooth/hci_h5.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


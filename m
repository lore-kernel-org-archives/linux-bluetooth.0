Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC33C6379D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC59208C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgKWL6r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:58:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36804 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgKWL6r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:58:47 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 87222CECD0;
        Mon, 23 Nov 2020 13:05:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/2] bluetooth: hci_event: consolidate error paths in
 hci_phy_link_complete_evt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c7579df5-a69b-d9e7-ccb6-6a7b2fc23d4a@omprussia.ru>
Date:   Mon, 23 Nov 2020 12:58:44 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <69CEE0E0-E71B-480E-B009-5B5E9475B510@holtmann.org>
References: <bbdd9cbe-b65e-b309-1188-71a3a4ca6fdc@omprussia.ru>
 <b508265e-f08f-ea24-2815-bc2a5ec10d8d@omprussia.ru>
 <EA8EC09F-6AB5-45DD-9889-C05D1FC9AAE6@holtmann.org>
 <c7579df5-a69b-d9e7-ccb6-6a7b2fc23d4a@omprussia.ru>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sergey,

>>> hci_phy_link_complete_evt() has several duplicate error paths -- consolidate
>>> them, using the *goto* statements.
>>> 
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
>>> 
>>> ---
>>> net/bluetooth/hci_event.c |   16 ++++++----------
>>> 1 file changed, 6 insertions(+), 10 deletions(-)
>> patch has been applied to bluetooth-next tree.
> 
>   What about the 2nd patch?

must have been slipping somehow. Can you please re-send against bluetooth-next.

Regards

Marcel


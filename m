Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C39CC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 21:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3050F61926
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 21:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFYVq5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jun 2021 17:46:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53901 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVq5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jun 2021 17:46:57 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9739ACED16;
        Fri, 25 Jun 2021 23:44:34 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: Fix handling of
 HCI_LE_Advertising_Set_Terminated event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210623035902.3572144-1-luiz.dentz@gmail.com>
Date:   Fri, 25 Jun 2021 23:44:34 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <28A15EE5-076C-4CA9-9BBD-5E48A8961E2B@holtmann.org>
References: <20210623035902.3572144-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Error status of this event means that it has ended due reasons other
> than a connection:
> 
> 'If advertising has terminated as a result of the advertising duration
> elapsing, the Status parameter shall be set to the error code
> Advertising Timeout (0x3C).'
> 
> 'If advertising has terminated because the
> Max_Extended_Advertising_Events was reached, the Status parameter
> shall be set to the error code Limit Reached (0x43).'
> 
> Fixes: acf0aeae431a0 ("Bluetooth: Handle ADv set terminated event")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


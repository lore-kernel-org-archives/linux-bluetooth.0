Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4174AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A67161090
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbhIXJuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:50:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44234 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbhIXJuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 05:50:20 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id EF081CECF2;
        Fri, 24 Sep 2021 11:48:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: hci_h5: directly return
 hci_uart_register_device() ret-val
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210924094231.32578-1-hdegoede@redhat.com>
Date:   Fri, 24 Sep 2021 11:48:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <DFE65492-C6F6-4950-93A8-923A048A144D@holtmann.org>
References: <20210924094231.32578-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> Since the hci_uart_register_device() call is the last thing we do in
> h5_serdev_probe() we can simply directly return its return-value.
> 
> Cc: Archie Pusaka <apusaka@google.com>
> Suggested-by: Archie Pusaka <apusaka@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_h5.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


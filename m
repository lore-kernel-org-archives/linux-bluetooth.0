Return-Path: <SRS0=JmZN=C5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C833BC43465
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A51A2085B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgITGWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Sep 2020 02:22:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32788 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgITGWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Sep 2020 02:22:33 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 86496CECBE;
        Sun, 20 Sep 2020 08:29:29 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2] Bluetooth: Fix auto-creation of hci_conn at Conn
 Complete event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200814190909.361764-1-sonnysasaka@chromium.org>
Date:   Sun, 20 Sep 2020 08:22:31 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <AD524EC5-2AC9-4B3A-ACC9-E896E5EFCB2A@holtmann.org>
References: <20200814190909.361764-1-sonnysasaka@chromium.org>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Currently the code auto-creates hci_conn only if the remote address has
> been discovered before. This may not be the case. For example, the
> remote device may trigger connection after reboot at already-paired
> state so there is no inquiry result found, but it is still correct to
> create the hci_conn when Connection Complete event is received.
> 
> A better guard is to check against bredr allowlist. Devices in the
> allowlist have been given permission to auto-connect.
> 
> Fixes: 4f40afc6c764 ("Bluetooth: Handle BR/EDR devices during suspend")
> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ---
> net/bluetooth/hci_event.c | 17 +++++++++++------
> 1 file changed, 11 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


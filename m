Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE08C64F03
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZU0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:26:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37097 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhBZUYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:24:52 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fb90.dip0.t-ipconnect.de [79.249.251.144])
        by mail.holtmann.org (Postfix) with ESMTPSA id 152C7CEC82;
        Fri, 26 Feb 2021 21:31:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v4] Bluetooth: Keep MSFT ext info throughout a hci_dev's
 life cycle
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210127091600.v4.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
Date:   Fri, 26 Feb 2021 21:23:41 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3439488F-ED5C-467A-BB67-B21A2CEAD268@holtmann.org>
References: <20210127091600.v4.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> This moves msft_do_close() from hci_dev_do_close() to
> hci_unregister_dev() to avoid clearing MSFT extension info. This also
> re-reads MSFT info upon every msft_do_open() even if MSFT extension has
> been initialized.
> 
> The following test steps were performed.
> (1) boot the test device and verify the MSFT support debug log in syslog
> (2) restart bluetoothd and verify msft_do_close() doesn't get invoked
>    and msft_do_open re-reads the MSFT support.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v4:
> - Re-read the MSFT data instead of skipping if it's initiated already
> 
> Changes in v3:
> - Remove the accepted commits from the series
> 
> net/bluetooth/hci_core.c |  4 ++--
> net/bluetooth/msft.c     | 21 ++++++++++++++++++---
> 2 files changed, 20 insertions(+), 5 deletions(-)

can you please re-base this against bluetooth-next tree since it no longer applies cleanly. Thanks.

Regards

Marcel


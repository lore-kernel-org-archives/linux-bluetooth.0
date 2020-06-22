Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3422073E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 14:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFVOE3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:04:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34633 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgFVOE3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 10:04:29 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01A4ACED29;
        Mon, 22 Jun 2020 16:14:20 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] Bluetooth: use configured params for ext adv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200622133028.26882-1-alainm@chromium.org>
Date:   Mon, 22 Jun 2020 16:04:28 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <796C3F6A-D9E9-4C20-A9BC-5DB53E2A21C4@holtmann.org>
References: <20200622133028.26882-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> When the extended advertisement feature is enabled, a hardcoded min and
> max interval of 0x8000 is used.  This patch fixes this issue by using
> the configured min/max value.
> 
> This was validated by setting min/max in main.conf and making sure the
> right setting is applied:
> 
> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen
> 25                                          #93 [hci0] 10.953011
> …
> Min advertising interval: 181.250 msec (0x0122)
> Max advertising interval: 181.250 msec (0x0122)
> …
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> 
> ---
> 
> Changes in v3:
> -adding 3 octet comment back per Marcel's suggestion
> 
> Changes in v2:
> -fix commit title and typo in description.
> -Moved le24 convertion to  hci_cpu_to_le24
> 
> include/net/bluetooth/hci.h | 8 ++++++++
> net/bluetooth/hci_request.c | 7 +++----
> 2 files changed, 11 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


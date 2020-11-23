Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20341C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3282076E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKWMBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:01:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33582 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgKWMBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 07:01:42 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7D774CECD0;
        Mon, 23 Nov 2020 13:08:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix not sending Set Extended Scan Response
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201114004434.3852104-1-luiz.dentz@gmail.com>
Date:   Mon, 23 Nov 2020 13:01:40 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FBC2BFA6-676E-4D95-BA27-EB0C65B80B6A@holtmann.org>
References: <20201114004434.3852104-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Current code is actually failing on the following tests of mgmt-tester
> because get_adv_instance_scan_rsp_len did not account for flags that
> cause scan response data to be included resulting in non-scannable
> instance when in fact it should be scannable.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_request.c | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB993C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBB8222C4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgADJuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:50:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34210 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgADJuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 04:50:05 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5FC8CCED13;
        Sat,  4 Jan 2020 10:59:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [RFC 1/3] Bluetooth: HCI: Add support for LE PHY Update Complete
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200102230057.31326-1-luiz.dentz@gmail.com>
Date:   Sat, 4 Jan 2020 10:50:04 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <294E6BFE-CEF3-4E7F-9E6D-7F7A0334DBE3@holtmann.org>
References: <20200102230057.31326-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This handles LE PHY Update Complete event and store both tx_phy and
> rx_phy into hci_conn.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h      |  8 ++++++++
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_event.c        | 27 +++++++++++++++++++++++++++
> 3 files changed, 37 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


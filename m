Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B8C3F2CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D11222C2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgB1Hkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:40:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50427 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1Hkm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 02:40:42 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 507ABCECF7;
        Fri, 28 Feb 2020 08:50:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] Bluetooth: Fix - During le_conn_timeout disable
 EXT_ADV
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200224052340.14409-1-sathish.narasimman@intel.com>
Date:   Fri, 28 Feb 2020 08:40:40 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <3DE7B9FF-A79D-4941-B976-91AB4CC5E3E0@holtmann.org>
References: <20200224052340.14409-1-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Disabling LE_LEGACY_ADV when LE_EXT_ADV is enabled causes 'command
> disallowed . This patch fixes that issue and disables EXT_ADV if
> enabled.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> net/bluetooth/hci_conn.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


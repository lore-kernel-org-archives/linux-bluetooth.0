Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34539C34031
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1597A206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgBRI0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:26:43 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39204 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgBRI0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 03:26:43 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 983AACED24;
        Tue, 18 Feb 2020 09:36:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: FIX - Disable EXT Adv if enabled
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200217090744.909-1-sathish.narasimman@intel.com>
Date:   Tue, 18 Feb 2020 09:26:41 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <18CB6BDB-147A-4D85-9570-8F7FF2DF4E8B@holtmann.org>
References: <20200217090744.909-1-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Disabling LEGACY_ADV when EXT_ADV is enabled causes
> 'command disallowed' during DIRECTED_ADV. This Patch fixes this
> issue.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> net/bluetooth/hci_conn.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


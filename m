Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2AC43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F661206BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 07:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIMH7A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Sep 2020 03:59:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52930 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIMH66 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Sep 2020 03:58:58 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id E268DCECC4;
        Sun, 13 Sep 2020 10:05:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] Bluetooth: btintel: Refactor firmware download
 function
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1599824657-19464-1-git-send-email-kiran.k@intel.com>
Date:   Sun, 13 Sep 2020 09:58:56 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Kiran K <kiran.k@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <02F01161-2498-4A89-A8B5-3F19D62143E0@holtmann.org>
References: <1599824657-19464-1-git-send-email-kiran.k@intel.com>
To:     Kiran K <kiraank@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Split firmware download code into two functions - one to download
> header and other to download payload. This patch enhances readability
> and reusabiltiy of code
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> drivers/bluetooth/btintel.c | 35 ++++++++++++++++++++++++++++++-----
> 1 file changed, 30 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


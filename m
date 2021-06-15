Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922AC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46603610EA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOT1P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:27:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56851 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOT1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:27:14 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id C1485CECFB;
        Tue, 15 Jun 2021 21:33:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v9 01/10] Bluetooth: enumerate local supported codec and
 cache details
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
Date:   Tue, 15 Jun 2021 21:25:08 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BB62EB90-BF5E-48BF-B5C5-72B410AF7025@holtmann.org>
References: <20210608122455.19583-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Move reading of supported local codecs into a separate init function,
> query codecs capabilities and cache the data
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>

what is Reported-by? This makes no sense since this is original code.

Regards

Marcel


Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56FC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77321852
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLRQ0d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:26:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50194 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRQ0d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 11:26:33 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 85504CF35D;
        Tue, 18 Dec 2018 17:34:10 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v3 00/30] Major rewrite for Multi-Node and DBus
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>
Date:   Tue, 18 Dec 2018 17:26:30 +0100
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5F351471-7372-4486-B8A9-5D146AB60160@holtmann.org>
References: <20181215002624.9313-1-brian.gix@intel.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E01AF@ORSMSX101.amr.corp.intel.com>
 <17761993.WvVeqkb5i9@ix> <398288BA-8B31-4D3F-97CE-62E4CD683923@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>>> This patch-set has been applied upstream.
>> 
>> There is something wrong with Makefile.mesh
> 
> This was tested by us on Fedora 27 and 28, without issues.
> 
> What build platform produced these errors?

start adding Fedora 29 to your test platform. However this has nothing to do with Fedora 29, the whole idea of just commenting something out and committing it is just not something we do. Actually it is something that should never be done if you are operating with git. Use your personal trees for testing.

> Since Marcel is backing out the entire patchset, we will create a v4 patchset that removes btmesh (the non-daemon executable) entirely.  It probably won’t actually be needed in the future anyway... The DBus APIs should be sufficient.

Be careful to not take tools away from people that might depend on it right now.

Regards

Marcel


Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A48C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 11:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D41C214C1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 11:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D41C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeLFLAi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:00:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35830 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFLAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Dec 2018 06:00:38 -0500
Received: from marcel-macbook.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id E5963CF364;
        Thu,  6 Dec 2018 12:08:12 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: ELL changes breaking BlueZ tip?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2A17A357-6C9F-4632-B9D2-3132EC379EF6@gmail.com>
Date:   Thu, 6 Dec 2018 12:00:36 +0100
Cc:     Brian Gix <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D66C732F-4738-4E46-8B22-76EDCD99102E@holtmann.org>
References: <DEBB0CAA2616974FAE35E4B560B9A4375C13D7A5@ORSMSX103.amr.corp.intel.com>
 <E2B14DEE-C3A1-435F-AEAF-ACBE239B76B8@holtmann.org>
 <2A17A357-6C9F-4632-B9D2-3132EC379EF6@gmail.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

>>> I am getting significant compile errors trying to build bluez on the master tip today, that seem to be related to new ELL external v internal changes?
>>> 
>>> Build environment: vanilla Fedora 28 with ELL version 0.15 installed
>>> 
>>> 
>>> It starts out by complaining that there is no rule to build:
>>> ell/util.c
>> 
>> please re-run ./bootstrap-configure and I would urge to use the internal ELL following the description in README. Mind you that only internal ELL related files are linked and build when either --enable-mesh or --enable-btpclient is selected.
> 
> ./bootstrap-configure && make does’t work for me either:
> 
>  CC       ell/util.lo
> ell/util.c:27: error: "_GNU_SOURCE" redefined [-Werror]
> #define _GNU_SOURCE
> 
> In file included from ell/util.c:24:
> ./config.h:97: note: this is the location of the previous definition
> # define _GNU_SOURCE 1

that is from Lucas’ patch adding #define _GNU_SOURCE 1 into config.h. We need to revert that only real users of _GNU_SOURCE define it in their .c files.

Regards

Marcel


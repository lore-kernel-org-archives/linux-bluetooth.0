Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC37C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C222207FF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgDCQ4D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:56:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52897 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgDCQ4D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 12:56:03 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6D6D2CED02;
        Fri,  3 Apr 2020 19:05:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] tools/hciattach_ath3k: Load BT board data based on
 country code
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOxioNm27+wmWeCp+hoWCF-5W1=xm_gdvn3xWbDJVeYE=wmyiQ@mail.gmail.com>
Date:   Fri, 3 Apr 2020 18:56:01 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, yixiang@google.com,
        Zhifeng Cai <caiz@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CC80769E-941D-4AD9-AFB3-C24DD84E940D@holtmann.org>
References: <20200331003355.14614-1-sonnysasaka@chromium.org>
 <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org>
 <CAOxioNm27+wmWeCp+hoWCF-5W1=xm_gdvn3xWbDJVeYE=wmyiQ@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Thanks for your feedback. I will take note of this deprecation plan.
> For now, Chromium OS can have a local patch to accomplish this and in
> the future we will migrate to serdev instead of hciattach.

I can apply the patch if you are still using it, but be aware of that fact that we are going to kill hciattach latest when we move to the 6.x major version number.

Using serdev is a lot better, cleaner and simpler in the end. So I would urge to make that change rather sooner than later.

In addition, I would really like to kill hci_uart.ko driver as well. That one has become a beast with a bunch of hacks that will eventually backfire. Since we have serdev now, I think each vendor should get their own driver. I have posted examples to btuart.ko and bt3wire.ko drivers that could be used as base.

Regards

Marcel


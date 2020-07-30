Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EBCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0537B206F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgG3J4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:56:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57345 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgG3J4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 05:56:37 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31140CECF2;
        Thu, 30 Jul 2020 12:06:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 8/8] Bluetooth: Enable controller RPA resolution using
 Experimental feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOVXEJ+hz7j9MnYU1hWrvM5itg_xumjWgyYTTYOQazEG9Y17gQ@mail.gmail.com>
Date:   Thu, 30 Jul 2020 11:56:36 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E88DC211-F19B-4E67-B706-DD9DF0DFCFBD@holtmann.org>
References: <20200730091421.48847-8-marcel@holtmann.org>
 <CAOVXEJ+hz7j9MnYU1hWrvM5itg_xumjWgyYTTYOQazEG9Y17gQ@mail.gmail.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Satish,

> I am ok with your changes.
> Including all the patches

ok, all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69CC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5B22073C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgK3RKr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:10:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45899 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3RKr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 12:10:47 -0500
Received: from [172.20.10.2] (tmo-111-84.customers.d1-online.com [80.187.111.84])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2FBFCED17;
        Mon, 30 Nov 2020 18:17:18 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: Support for LE Set/Read PHY APIs
From:   Marcel Holtmann <marcel@holtmann.org>
X-Priority: 3
In-Reply-To: <20201127090950epcms5p2af83accad82795ea00e1d1535e46327f@epcms5p2>
Date:   Mon, 30 Nov 2020 18:10:04 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <8631953D-2B5B-4870-A710-0F98BA58512D@holtmann.org>
References: <CGME20201127090950epcms5p2af83accad82795ea00e1d1535e46327f@epcms5p2>
 <20201127090950epcms5p2af83accad82795ea00e1d1535e46327f@epcms5p2>
To:     ayush.garg@samsung.com
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ayush,

> It seems that at present, there is no implementation of BT5.0 PHY based HCI commands - 'LE Set PHY' and 'LE READ PHY' to request controller to change connection specific PHY settings (2M PHY, coded PHY etc).
> Could you please tell if there is any plan or ongoing work to support the same.
> If not, Kindly suggest some flow on how can an application request the controller to set or read phy settings via kernel interface.

you can propose something.

Regards

Marcel


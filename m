Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F5C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C445961168
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbhHSOvV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:51:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51063 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbhHSOvU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 10:51:20 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 40679CED16;
        Thu, 19 Aug 2021 16:50:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support different nvm to
 distinguish different factory for WCN6855 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <fcd7e83c3cd39ea89c94345ec00b5c6c@codeaurora.org>
Date:   Thu, 19 Aug 2021 16:50:42 +0200
Cc:     Zijun Hu <zijuhu@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        c-hbandi@codeaurora.org, Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, rjliao@codeaurora.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E7BEF38D-E8CA-4ABE-A025-9C60E10CA797@holtmann.org>
References: <1628758216-3201-1-git-send-email-zijuhu@codeaurora.org>
 <fcd7e83c3cd39ea89c94345ec00b5c6c@codeaurora.org>
To:     tjiang@codeaurora.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tim,

>  could you help review this patch ? thank you.
> tjiang

if the kernel test robot throws an error, I am not even looking at a patch. You need to fix these first.

Regards

Marcel


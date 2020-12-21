Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FD922B51
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLURy1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 12:54:27 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37512 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLURy1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 12:54:27 -0500
Received: from marcel-macbook.holtmann.net (p4fefc632.dip0.t-ipconnect.de [79.239.198.50])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE810CECFA;
        Mon, 21 Dec 2020 19:01:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [Bluez PATCH v2 1/2] doc/mgmt-api: Add opcode for adding
 advertisement monitor with RSSI
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201215181024.Bluez.v2.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Date:   Mon, 21 Dec 2020 18:53:44 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BD5C9B5F-7694-4AC3-8652-F909B65FD5E3@holtmann.org>
References: <20201215181024.Bluez.v2.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> This is to leverage the filtering by RSSI feature on those controllers
> which supports advertisement packet filtering. To avoid changing the
> existing API and breaking it, a new opcode is required.
> 
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> ---
> 
> (no changes since v1)
> 
> doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)

patch has been applied.

Regards

Marcel


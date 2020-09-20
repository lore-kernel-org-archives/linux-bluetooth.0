Return-Path: <SRS0=JmZN=C5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F4AC43466
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BBE20888
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgITGSr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Sep 2020 02:18:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36698 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgITGSr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Sep 2020 02:18:47 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1E7B8CECA3;
        Sun, 20 Sep 2020 08:25:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] Bluetooth: Check for encryption key size on connect
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200917181031.v1.1.I67a8b8cd4def8166970ca37109db46d731b62bb6@changeid>
Date:   Sun, 20 Sep 2020 08:18:45 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <428C3B9F-1C03-4BD9-A1AF-21D2F99A7F3C@holtmann.org>
References: <20200917181031.v1.1.I67a8b8cd4def8166970ca37109db46d731b62bb6@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> When receiving connection, we only check whether the link has been
> encrypted, but not the encryption key size of the link.
> 
> This patch adds check for encryption key size, and reject L2CAP
> connection which size is below the specified threshold (default 7)
> with security block.

please include btmon trace in the commit message to demonstrate this.

Regards

Marcel


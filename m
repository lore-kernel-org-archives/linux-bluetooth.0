Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF563C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869972083B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 18:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgIPSCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:02:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41719 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgIPSCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 14:02:11 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id B0D7ECED03;
        Wed, 16 Sep 2020 16:29:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: pause/resume advertising around suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200915141229.1.Icfac86f8dfa0813bba6c7604c420d11c3820b4ab@changeid>
Date:   Wed, 16 Sep 2020 16:22:47 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <21AC2E8F-BEC6-431D-89BB-8F2E3EDFBBC1@holtmann.org>
References: <20200915141229.1.Icfac86f8dfa0813bba6c7604c420d11c3820b4ab@changeid>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> Currently, the controller will continue advertising when the system
> enters suspend. This patch makes sure that all advertising instances are
> paused when entering suspend, and resumed when suspend exits.
> 
> The Advertising and Suspend/Resume test suites were both run on this
> change on 4.19 kernel with both hardware offloaded multi-advertising and
> software rotated multi-advertising. In addition, a new test was added
> that performs the following steps:
> * Register 3 advertisements via bluez RegisterAdvertisement
> * Verify reception of all advertisements by remote peer
> * Enter suspend on DUT
> * Verify failure to receive all advertisements by remote peer
> * Exit suspend on DUT
> * Verify reception of all advertisements by remote peer
> 
> Signed-off-by: Daniel Winkler <danielwinkler@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> net/bluetooth/hci_request.c | 67 +++++++++++++++++++++++++++++++------
> 1 file changed, 57 insertions(+), 10 deletions(-)

Patch has been applied to bluetooth-next tree.

Regards

Marcel


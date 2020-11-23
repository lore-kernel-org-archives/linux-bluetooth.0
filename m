Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B917C56202
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A2920738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgKWL2e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:28:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56293 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgKWL2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:28:34 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2E330CECCF;
        Mon, 23 Nov 2020 12:35:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] include/net/bluetooth/mgmt.h: fix typo in struct name
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201119073710.385004-1-reoshiseki@gmail.com>
Date:   Mon, 23 Nov 2020 12:28:31 +0100
Cc:     linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <16B64FCB-A028-435A-A522-8B2ECEEDC3A4@holtmann.org>
References: <20201119073710.385004-1-reoshiseki@gmail.com>
To:     n01e0 <reoshiseki@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

> Signed-off-by: n01e0 <reoshiseki@gmail.com>
> ---
> include/net/bluetooth/mgmt.h | 4 ++--
> net/bluetooth/mgmt.c         | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


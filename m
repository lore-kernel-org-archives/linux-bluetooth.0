Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB37C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 23:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CAA61037
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 23:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJVXU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 19:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhJVXU5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 19:20:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4081B6054F;
        Fri, 22 Oct 2021 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634944719;
        bh=pzihPd8qvkfhNXZg/5CyzVSAumb/oQ1bis0eDGaRcdg=;
        h=From:To:Cc:Subject:Date:From;
        b=FWXOc2isGH+vpu1knjCE7s9q7wuvkBz3uGlCSgi4y2e8XOHqckXjmdMvsz72v+Q3j
         OlZ1lCVXz2kqSA0VJHWIWdCErEd6bHUukPnv5ppIcZMyYsnwsSYruhn+NanGhvW0y/
         vuvVE67Ng4GPZi47rHij/nP6wjLJZtYI3Ackepvcm5uYwOphZnE3/8QI2gyHaHeA4K
         WVEBteYyMFBWT9/OYMGd4QqTdGIBRip41AEUGF11Le9FZDwlu2D16AFvPzmVxh1tXX
         lMrOlUbPjYKmueoal0uAkmHKfSayBY3iXKKlN8flT44YTdCGgpUzLvwEtjpVQiaUS3
         inuctJT3lERLQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] bluetooth: don't write directly to netdev->dev_addr
Date:   Fri, 22 Oct 2021 16:18:32 -0700
Message-Id: <20211022231834.2710245-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The usual conversions.

These are intended to be merged to net-next directly,
because bluetooth tree is missing one of the pre-req
changes at the moment.

v2: s/got/go/

Jakub Kicinski (2):
  bluetooth: use eth_hw_addr_set()
  bluetooth: use dev_addr_set()

 net/bluetooth/6lowpan.c   | 4 +++-
 net/bluetooth/bnep/core.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.31.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4BC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 09:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiFIJZf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFIJZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 05:25:34 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 02:25:33 PDT
Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FB6FA14
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 02:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654765826; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=e641z0mJvvc0uO6vgymL4RTCjS5EwDJeZ8+AeDA3wGBLif+5UF/q2aEQW8uatHBJva3Kz7HAmlYqIBKOuG+yHuv9qrztBheqQdvInXjRwaiKqAkUDE40MgnV35I/Yw2lzqts4cCncekmMKQ5Cosv7rteJk8ddzBskVs1JG/hivg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654765826; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=A34hItfXyw3S/iUXZwSd9/Q6mZji/EFLd4UxO6VAB90=; 
        b=hUCt6a8WsIEoviaDkWDzMJULx3whO0rZluAYhnCDhxAdvWDnFxTCQlvjOUiPoT123oLpu3N5uZo4zCbyQT8aOZRnqOKPDgvYdhjFkEp5vQxjaFXYZRHBznaKj+sNLk806jFfObHneJR0EJbnMyhRpe6+UwAospvMi3MxQGcbywk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=jonas@dptechnics.com;
        dmarc=pass header.from=<jonas@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654765826;
        s=zoho; d=dptechnics.com; i=jonas@dptechnics.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=A34hItfXyw3S/iUXZwSd9/Q6mZji/EFLd4UxO6VAB90=;
        b=D//k+N8QaG8198fJmyW7cv6VRoMhrLBCOe4XiwZKbnwUoHO0grnixMljglLB38V5
        AsCeXPVqB2yUuL6mfQfw8RKUWUlYzrxCnM9pFy2FdhylPqH2iej885pamwkG8TBb1rL
        GD/3jZftsVcoDWInOJHER4TkGYQDxvIh55RKTPrk=
Received: from lilith.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1654765825093564.3171272718093; Thu, 9 Jun 2022 02:10:25 -0700 (PDT)
From:   Jonas Maes <jonas@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jonas Maes <jonas@dptechnics.com>
Subject: [PATCH BlueZ 0/1] Fix bug where bluetooth-meshd stops sending
Date:   Thu,  9 Jun 2022 11:08:31 +0200
Message-Id: <20220609090832.9945-1-jonas@dptechnics.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes a bug where bluetooth-meshd may stop invoking the tx
worker thread and hence stop broadcasting, accumulating all packets
in its tx_pkts queue instead.

Jonas Maes (1):
  Fix bug where bluetooth-meshd stops sending

 mesh/mesh-io-generic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.34.1


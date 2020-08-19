Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6983C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3252F206FA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="lpI5xi0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHSN2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:28:08 -0400
Received: from ns.omicron.at ([212.183.10.25]:45256 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgHSN2H (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 09:28:07 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 09:28:06 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07JDMd7Y020945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:39 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07JDMd7Y020945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597843359;
        bh=ccYcGYY6Mbw1HaaTbPxfuOr7peGZ50PxigpPLEqCJwc=;
        h=From:To:CC:Subject:Date:From;
        b=lpI5xi0+LOI7APFxlu1G4JXWK6oKSB9CNe8OdpUIR0mC7RoPrVuw0WIv/7AzVnhON
         wHISDxCsvOARycfjLUspEnHrZUVnV8Y9FTR/Q8Qc1NniGHGmLSiLAjUKRA7gd+G3Nl
         kbHTM8MgPWq+17j/I6j3PJgxYRfpRkW8o06fzaqE=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 4FAB0A0064
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:38 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 4D846A0062
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:38 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07JDMdeZ021520-07JDMdeb021520
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Wed, 19 Aug 2020 15:22:39 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:22:38 +0200
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Mark Marshall <markmarshall14@gmail.com>
Subject: [PATCH BlueZ 0/2] Fix a couple of endian issues
Date:   Wed, 19 Aug 2020 15:22:29 +0200
Message-ID: <20200819132231.22673-1-mark.marshall@omicronenergy.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mark Marshall <markmarshall14@gmail.com>

I'm running BlueZ on a big-endian platform, and have found a couple of
small endian issues with the tools code.

Mark Marshall (2):
  btiotest: Correct setting of addr_type for big-endian platforms
  l2test: Correct the endian handling

 tools/btiotest.c |  7 ++++---
 tools/l2test.c   | 14 +++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.17.1


Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA9C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7C20836
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="AZJdP+xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKYMbv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:31:51 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41001 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYMbv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:51 -0500
Received: by mail-wr1-f51.google.com with SMTP id b18so17793931wrj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJCpcSpfPZuvWeVXC8ejepeMr2O+cRN3l77vJHAz7ns=;
        b=AZJdP+xPvqhvbFJJSRKdRQ+prgRLOzrwOhWkMqoQFgORbmEgcyWgccta0A/0yQbmWh
         42fxHQkzRzsY1xR4cKSgn+zFg9bcNPE+aUiQoksQgePNNPYpbLTam1C88irFpbVPD/K0
         qVFanv5oPj5ZsqCYl/+vX9vSpT89hozCcS3fJuaOnK2r9QU00uxy2yU5p0CtWpamoe/r
         S01bAdkDUmKtjWoJ3jkoyl7CDpWL/ffhWDTWw+0sOA9DmefipjNfjfdgsuu4Jnimvxwa
         HV2U5xmb7lwu3f0FWlhnSHYML/+L5OgqhSm7kQhTLhdB1oTBm09IIz94lr9j/nmcWscU
         arQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJCpcSpfPZuvWeVXC8ejepeMr2O+cRN3l77vJHAz7ns=;
        b=mZsuPz2UTfb/Rla/0Wmf+Z7EzXKYR0njMro7S1N9UYpTu08RJmvLexLphOieSvUuK1
         03r3W+F4dWL9tWkIP3xxEqUGkyVWmBTgOgX39yFhAdCTcMJ6x0exfVllG95OWi1wiVgE
         +1F8jsocbiodQ60V8EfEdoYrrM6Grf5NXgP7L1nrwnfvskEpOIeEYt6XxCzUPNc+HAth
         N9xVcmMyl5s/QSFNy8LOLkknON06mNe3JTqJ/iT8riMmUvOkVtonU3Sm3BizB2iG5y7V
         Rw0z73JFA5ZAW0Hgg168a6sJs+4ri0M2VPGtOFaf74FqCrlmtt4AaCb3dMNV/+7EK64B
         bFoQ==
X-Gm-Message-State: APjAAAUtHlSyNrhiFLARlX/2EfPdfSOARRFDRNo1IVsv6PbN6Vyq90LZ
        kAbuhL2EIZEsRYLEXG8J1KXOTN7VVU5HZQ==
X-Google-Smtp-Source: APXvYqxM0ozsa4E3Vr2pfnegota0Wraw+AbF188nqh1z+9yPseSRARv2k46tLJQMFiIEhMshm6kPzw==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr32517662wrc.150.1574685109250;
        Mon, 25 Nov 2019 04:31:49 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w4sm10257553wrs.1.2019.11.25.04.31.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:31:48 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Include destination address in MessageReceived API
Date:   Mon, 25 Nov 2019 13:31:39 +0100
Message-Id: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset changes the MessageReceived API, replacing 'subscription'
flag with destination address of received messages.

The application receives destination address as a D-Bus variant,
containing either as a regular 16bit address (unicast/group) or a
16-octet virtual label.

See previous discussion https://marc.info/?t=156719067300001&r=1&w=2 for
rationale.

v2: Fix test scripts:
 - fix API in test-join
 - display model subscriptions in test-join and test-mesh


Michał Lowas-Rzechonek (3):
  mesh: Fix test-join to include mandatory VendorModels property
  mesh: Provide destination address in MessageReceived API
  mesh: Inform application about model subscriptions

 doc/mesh-api.txt |  32 +++++++++++---
 mesh/model.c     | 107 ++++++++++++++++++++++++++++++++++++++++++++---
 test/test-join   |  37 +++++++++++++---
 test/test-mesh   |  33 ++++++++-------
 4 files changed, 179 insertions(+), 30 deletions(-)

-- 
2.19.1


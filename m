Return-Path: <SRS0=UJar=3C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5AC33CAD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8E2084D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JyZo17JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMM1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:27:37 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:44929 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAMM1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jan 2020 07:27:37 -0500
Received: by mail-lj1-f179.google.com with SMTP id u71so9773356lje.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2020 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9QBatFu0uHfdZykzDH8ATKZkl+pbQFxPfrXPrtGbFQ=;
        b=JyZo17JR8PdmZO40W5PozZWBQ9PvrtMYMqSj7azyK+D8WgXHEZhILaqxF6du33qH4G
         Njy5Lnto7Wp1o4M4VNFkuv+T9A2UN9iYWREYQNnr9UdDSdbdV8gXr2FDx2hPXCbVthS+
         Zkew9sbO5cuGParkLBIghqqQDOR63mo933ttgTszWVy8S8X+lBXFhBeB79kvZ99dKCmo
         PPXI4c7+uX8kTT1wgysJIFQEnEmr1mKjOU/7AndgZACr5B43zh61JUT28sURE2ngbQa+
         q274ENp6IQkrHELV6yZ2CctkPGbJcPjHHlcX3vXtCv2gsDmciyyBaQXpWhD3U7c4SWFR
         DKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9QBatFu0uHfdZykzDH8ATKZkl+pbQFxPfrXPrtGbFQ=;
        b=R9h/MGryUAEvvsbNWDdYkeGwuxZqzipQ+IVOA2kXB6AKHWmyj7LzPD6VvPUMWFjxuL
         x/zQO64LmNUBdX1nZQngtxfnz90nBxtQzGxKrRzxY0jKlYLI8czd6U7baazZuXryiDyF
         XM1iesTKERn2ZKcOzvGsbqGNPhyBLHFw0K/hzYXfnSEs66TpbeJCH+xFE2qMC8h/mRUB
         j5PS8LUGHrN5ElclVDy8mHPXTomlWeGU52z8LlxjD02wHHb4cofusYGRCuT1Y059VeJ/
         FHguTqaFkXZXxkIGY+rsQch3n+/znJP9ndelXjBTXjl6hCqemQyh1m572bJuVDneP0tP
         vzoQ==
X-Gm-Message-State: APjAAAU9tzIoAqVkyOI26E1Ho9i1XY2fhq7LQmgqR0SJFTxHsdYPWr1Z
        c0roTtQJpEPWTWydUKas90GHi1CMT7Y=
X-Google-Smtp-Source: APXvYqwE+JFg1q5ZcexGoWzCgM7bVng9LPLdZ1UJHkAN8qnAVD9fLgam6MVQX97pcF9Zc3yQRvziqQ==
X-Received: by 2002:a2e:b1c3:: with SMTP id e3mr10196981lja.137.1578918454850;
        Mon, 13 Jan 2020 04:27:34 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l7sm5571758lfc.80.2020.01.13.04.27.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:27:34 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH RESEND BlueZ 0/1] Select mesh-io from command line
Date:   Mon, 13 Jan 2020 13:27:24 +0100
Message-Id: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Continuing changes started in 12b984d1d4d47a8fd5bc8455d586bb208b804ebf,
this patch allows us to select mesh-io type using command line
option.

By default, daemon still uses mesh-io-generic, and currently there are
no other implementations available, but this patch enables us to
register more io variants.

Michał Lowas-Rzechonek (1):
  mesh: Add --io option

 mesh/main.c | 99 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 18 deletions(-)

-- 
2.20.1


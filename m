Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45705C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D71D214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="TiTS2mw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAORJB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:09:01 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44423 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgAORJB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 12:09:01 -0500
Received: by mail-lj1-f171.google.com with SMTP id u71so19348829lje.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 09:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdcIJnOGEVHmE38OfU6Qs7Oy8VONN3G7DfrAt1NWFSE=;
        b=TiTS2mw1Z0lca3T0RyBssb/BATnN+5vd4RzKPDSnuPzViOxejAG99klsU7zPEo/ni3
         YkL1NicXtDoWUwV/8AVqmpcCDWYy9I3Okn3O7kxjLgS0MVHpSBXmAYcCwymA9FcAetpy
         M1f5jTmkid23e5iXl0eDusm5gTeGbMbCOd8D0hELyTgBQdmM9LJ2mJhxiYXpAZWF/yj/
         d7wLRznXDFTyuCtwjITrn//a8yN/nIz8qrVRYVJktqaIQmrSIt7EoyqK3S2+7BpJ7IVn
         Xw0cdFmofya7MtfSSa30u3s/G9o+2Waj1YR99FTKzIg9XyEz5FAKT2yT9bh2cOdhKacJ
         R41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdcIJnOGEVHmE38OfU6Qs7Oy8VONN3G7DfrAt1NWFSE=;
        b=rq5EtWZGgQ6s31u2ALygX6aM6RdJD4y8LtZyOgP0QMxnbukMbyQOob8hgoPEXsAMTu
         NSbVpUV4R9Pfr6cO7W+yhkVgDz/677Jy0bYwB6SZifoXFha+UNhO7LqCRLpYX/wPTSWC
         of2fTDmFyyg4kU9jc56jV/+vPlzNbrB7ECln3KgAfKq88HlQ+E7NRHr1yoN+HOqWMW4Q
         rl9Ffqs0VePaW84htqkV3w+rlwFc3FtgAhmFYghWRqcYVARDpE+dHVnoDfQgtboq9Df8
         +MgkhX+QXmLJ5VLPP/Px+Y5FkS7U6AwhkgmKqFilh1dwObEtwqg9+XV/k3a8/xmBec10
         x2eQ==
X-Gm-Message-State: APjAAAXI8vPtKenL1QuexHtOsKgO9PJAvqJIfPD8JeY6A2QD6nk3a7Vp
        P8Qy5N3h1euprijIpQ2yoK3tCKf6oguS4A==
X-Google-Smtp-Source: APXvYqwLb2Er3dmtXNt7rG7PvY385dRMMeKmKmYZjfTljD26Yw8dAbwObtvy3gMciSzclfeKCnifGw==
X-Received: by 2002:a2e:a486:: with SMTP id h6mr2484347lji.235.1579108139046;
        Wed, 15 Jan 2020 09:08:59 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m15sm9685972ljg.4.2020.01.15.09.08.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:08:58 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/1] Sequence number out of range fix
Date:   Wed, 15 Jan 2020 18:08:29 +0100
Message-Id: <20200115170830.7479-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During sending messages with high speed, the 'cached' value may have exceeded the 24-bit range
and this value will save into storage.

The current implementation protects us against exceeding max sequence number (0xFFFFFF).

Jakub Witowski (1):
  mesh: sequence number out of range fix

 mesh/mesh-config-json.c | 4 ++++
 mesh/net.c              | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.20.1


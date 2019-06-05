Return-Path: <SRS0=U5tA=UE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523EC28CC5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E547420684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jun 2019 13:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="0E9HbW2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfFENBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:01:19 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34640 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFENBT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jun 2019 09:01:19 -0400
Received: by mail-lf1-f54.google.com with SMTP id y198so8516213lfa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2019 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKSERM3vzndDIvqRs+nOF6GGZ2emxTwYUbaRxh0GqyM=;
        b=0E9HbW2RdELdGEeviQLMxB0ZSillYjSgUoBbvwecFaVTMDxb263kWXCMH14L3Vt4wI
         XEkx9QTcIZFDHhwyD1fP1bFVkH8eq+9c5Q3u06+r0JTlRiK4roRy+Q6nWnLoExxwxugz
         CbCRB7sq0xqa4MYac1z7hwn77odgtwbknyEsnj+D6AQchiR1ycfEm7jUFf46kd2kZ1B5
         OslxKvhDEmKs4wYuf1xM4YI3X3lb6J/vrA9p8xKzsrYd0ATBaoS7MD31w2UuBfioaP/G
         dsHwShH6aehTH4zqpgk1kpIkUqusblmXk0/KTvLx6b/3mVI2TJSeV8aaChmbP5DXKg3F
         /mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKSERM3vzndDIvqRs+nOF6GGZ2emxTwYUbaRxh0GqyM=;
        b=nRzW9u2nWxtXfRTaNdqfFbi3aSMBOcLOmc27qcwoay9+naT1DObnnZH8rQulqYcR5U
         IgjNVyyT9Rhn26ce+ohg32Tbw66+wYU8EGgmIpabnXnfFuq814H//zteX3N7MfEwLcUC
         m2syxnNsKeo6L3Ar0JeQZQmG27aAtqL59+xlcfRjWlAi/NFm/8wnomAeQyplQ5yt9x6M
         yYoPlYaJYa+97IzQEAJkJC7OqEa7U77Ch0htarTEEgphVwQ03Qln61AApSAHZhgfNGXy
         9/ttsnQRx3d1lVe4Ui0mNPmI3+mbbBxyGrYmX/XxS9tMO3cc+v9CDHHm1RiuMhgOdOM7
         hILQ==
X-Gm-Message-State: APjAAAUXIrYdOTz2TiG8o0LQHGsdGA/qO8bZYowM3/HkumlLqWPE6I+W
        tHiiFKNlHOsiIYQQG2kmsVRAgd9SlATfdA==
X-Google-Smtp-Source: APXvYqzJLPpMDdXwp8jxgmJDxLEOTrl0x1cINP0PER5bm+1uqrfXSs6TLFz5IZzOIZU+hi4874gtoA==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr16323977lfy.51.1559739677303;
        Wed, 05 Jun 2019 06:01:17 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y9sm4335699ljc.2.2019.06.05.06.01.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:01:16 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] Json storage refactor
Date:   Wed,  5 Jun 2019 15:01:03 +0200
Message-Id: <20190605130106.32372-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Netwrk keys, application keys and elements with models have been simplified in json storage file. Arrays objects are no longer required.

Jakub Witowski (3):
  mesh: Refactor elements related object in json file
  mesh: Refactor net keys related object in json file
  mesh: Refactor app key related object in json file

 mesh/mesh-db.c | 469 ++++++++++++++++++++++++++-----------------------
 1 file changed, 248 insertions(+), 221 deletions(-)

-- 
2.20.1


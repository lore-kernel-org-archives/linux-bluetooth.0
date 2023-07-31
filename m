Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146DC001DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 04:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGaENK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGaENI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 00:13:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222BE9
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 21:13:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991da766865so645894966b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690776786; x=1691381586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbPkYEu+cJCFer1kz1NatUxwyIHR6CGrgLJYy2L/a6s=;
        b=Z5OePBSDr7cdovdEuLe4B2HPRgGzLeo4IeB1+XsD/DPsCF2UVpaoZcHNjDct3ZhzJl
         mjmK/S320By4IaJh+YhqBKtNLYeRhn4JiqvP+FG7L3HPSqSas8g1li5QwS8Yf/B+IKXg
         BROOhdx8PJrpNYO6RojEiJQ7pAFvHZxrajdv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776786; x=1691381586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbPkYEu+cJCFer1kz1NatUxwyIHR6CGrgLJYy2L/a6s=;
        b=ButA07cVEuDHKHCjBsmtrmpdbfJXdgnj8NivqhavGWbEmfQZwTKsOMo9FnA5d84LEP
         CnoLpJLNDU5wc1kmRnP6+fTsIV4zL5BggpzN1ijey1vAOb+v9oPh0ZxBPpESSP4Zb7b9
         2nVraPPrbJzZLNb8XzRGEDeR3+52Ks5yyUNZo0fkq/8tTTSMKUQGTB3io+MfV9MFTlwm
         sh6fH9T3OIeiTD+ETHHIa8ZzdB0TYH4XphO4S1WHLWwUWUCos1lzrDgWC1cv6/wsFGym
         8OapFATZvvIpy+W/5D6dwASSITjojSu6H/NiFAGHiuAwP33ZkxIe1M7ZLJYL9bPJH8VU
         THqg==
X-Gm-Message-State: ABy/qLZVShSijyIuYPdve4OGRfqRiG43waNpxBMSTpEq6l66N3JBuvoM
        w2sf49qPwNJ7UKHep8HeYKiN2m+xNH4dW0qFy2s=
X-Google-Smtp-Source: APBJJlELZr+YV+jdc9A7iPXiRCo15Rtd1YrqDXLRXE5NCKHO2F+M88aFhLbNUKnQ8q+A8U2JZf3dCA==
X-Received: by 2002:a17:906:cc4f:b0:99b:bf8d:b7e1 with SMTP id mm15-20020a170906cc4f00b0099bbf8db7e1mr6080344ejb.17.1690776785895;
        Sun, 30 Jul 2023 21:13:05 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:622e:5334:a63b:c328])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906960f00b00988dbbd1f7esm5542361ejx.213.2023.07.30.21.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 21:13:05 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] adapter: Update ConnectDevice documentation
Date:   Mon, 31 Jul 2023 06:12:29 +0200
Message-Id: <20230731041229.1429016-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
References: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
 <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/adapter-api.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 9b2721c1b..d38ce7171 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -177,12 +177,13 @@ Methods		void StartDiscovery()
 			performing General Discovery. Connection mechanism is
 			similar to Connect method from Device1 interface with
 			exception that this method returns success when physical
-			connection is established. After this method returns,
+			connection is established and you can specify bearer to
+			connect with parameter. After this method returns,
 			services discovery will continue and any supported
 			profile will be connected. There is no need for calling
 			Connect on Device1 after this call. If connection was
 			successful this method returns object path to created
-			device object.
+			device object or device that already exist.
 
 			Parameters that may be set in the filter dictionary
 			include the following:
-- 
2.34.1


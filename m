Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA94C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE5F217F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="1+FM+7ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfH1Hwi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:52:38 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53561 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfH1Hwi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 03:52:38 -0400
Received: by mail-wm1-f42.google.com with SMTP id 10so1657752wmp.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2019 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhIFioLaUJImLeuqn++5o36LUzuw5d0y45i9Jsx8If8=;
        b=1+FM+7ze8VOVuUD4sAdAGOmwvdBxpBIKvETq5RY3ksKU90xc8ncnebB4SZaD0jwXUl
         IeDeBA2uCV+2cUC0CNTVprSXIDA8Wy3u6HGNk4jFXWJ2dZ05G4juST5bfMsD6jnTtYnI
         VYOwo7VZIqGAyYJtxrifTOERDtE/8dDAB+O9ezS5gp9jL+Q9cKz7OIz5cJJ9m0avhDmn
         fAsm0YDKOZeG833GOQsAJ4XUAKUs3HAFNcTkU8I0+yCfCqttbpeEtNR0fmAPW4l1JGYq
         +BxFaTGgLZ5phgiX9sbq+ju25JPSmJdDfBwcqZ9BfuPBANI6SIRYsmH2eQiw7Oxnw2lF
         AgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhIFioLaUJImLeuqn++5o36LUzuw5d0y45i9Jsx8If8=;
        b=TzEmZTM9AyVrJHyu2gJlNGw7UnK/UbJ8rsG3hpt3wwOi5N0K32b6Gd5oElUwlFFaSD
         fkhWfyFSM8zmU6fL9XuwTpbCVOVnm1XMvg+KAFCyi2EhO/6Z9+adyhmnHv7lWoDo8m7e
         BOHTHm0sS+vJJnglW7o0vdma22sXpQBDoTvHTWt2bJ6NbRarKbxGOdC+AQ/38jLC4hDp
         aGheNTR/kOrb902tgtECvFg2gH1vEgnVmQ3AGbFbdasIcZD9fIadPNK4CJnT2KLKSy+L
         CmrKuoDlit4UXldj6caS2Br820p5NwKy9V98N9H3LOUaVfaYBugwz7QuDKz4mbOCsw2K
         FLcw==
X-Gm-Message-State: APjAAAWxst8A9Vjwq8GakJa9++9bZPfc2N6cQNjN1cC+j6KuQJ9Dxrl4
        rG7HvSaUAiTEQijpSccZFlNeO39Efxw=
X-Google-Smtp-Source: APXvYqxYoyRre00r/h83W46a5PzM6HBv2yueTfh/ws9bU0K4CnFAZGjHW9oLBYDEjECXQF4YSuTWUQ==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr3131620wml.102.1566978755548;
        Wed, 28 Aug 2019 00:52:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t7sm206958wrr.37.2019.08.28.00.52.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:52:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] mesh: Implement org.bluez.mesh.Node1 properties
Date:   Wed, 28 Aug 2019 09:52:28 +0200
Message-Id: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set implements previously defined properties on Node1
interface and adds an additional read-only property with list of unicast
addresses claimed by the node.

Michał Lowas-Rzechonek (2):
  mesh: Implement properties on org.bluez.mesh.Node1 interface
  mesh: Add org.bluez.mesh.Node1.Addresses property

 doc/mesh-api.txt |   4 ++
 mesh/net.c       |   4 ++
 mesh/net.h       |   1 +
 mesh/node.c      | 129 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.19.1


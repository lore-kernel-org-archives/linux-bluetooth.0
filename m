Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8CC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5321530
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="UudnHkeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEHOYw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 10:24:52 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33813 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEHOYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 10:24:52 -0400
Received: by mail-lj1-f169.google.com with SMTP id s7so12229243ljh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2019 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4pjMLEwPXW91l2kZqWaykFBLHcv8LhKQS62F02RhQw=;
        b=UudnHkeFWN5NoW/RVGbHPsH9oMQTiHWMPiT6wEQe/t/9KrViGSiI+N5z/HmZ42VTGT
         xClCeO7ptbMQksExkHmcJXsWbKXGRBZHwddvZdhtNPnGRaO14VKERcXxhfYLSYd94glN
         gpXvkNPDixN2//bh9ylbduw9bN/kRhAbryk5oongUT46g7afiMfCSdCk5IrFe9ZaxYd2
         uksb2KFKRdHyC2Oa4WadV0MMCOp5Ihn3oaR1LQwHcADqtYIu3vOAigmv3XqlC/+n3A+l
         Up+xvEdhqEDaG8tACsNRZY0eMAjeXWQX6j0TP128HfUqGV7RiRv9JkKO5oNn3BnoJZ56
         Igug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4pjMLEwPXW91l2kZqWaykFBLHcv8LhKQS62F02RhQw=;
        b=WWFuYZJfyAtbUAyuhH+dUBx779/8bWnlN2+ukXmCvKI6c9aV0NSUEIu9DQx7S0fJFg
         cLxVC8AogTphNoZOZEJBeK1WBAY2WwSXKX7Txo6s62D2l6g9WLnMJn/7kNL8/EZ6CG6P
         04+qo3ATWABNb4y8K5kAzdzEqJW3lU9qsohFsPszhcR3qH2K2JZLy2Vr+w4bfRT1JBhd
         qhg5LwWwG0T6wJ4iKsiAmbMU2iJGTa7X2aXxuKf7yOyGng/4p+WOBPzIP3ovcJ2ptek+
         XXbR4vKaDsFRgqAnKDdMkgksbGw4/RwvoSN8MG99XnKnKPnLlSBD/jjFkH/w2oIAsx9Z
         4yUw==
X-Gm-Message-State: APjAAAXfzzZiu8KTGeN4BqWNJTike9vqB66pVo0rP2J+KAgr+1RcEFNm
        /EcjzVVYGoayxiiCV5qEBMEih1X5hb8=
X-Google-Smtp-Source: APXvYqyBjLKRBhkEjPLOaxjacra4V3E/75RT70noQxUB7ueEo0b5bp/XJHsMbluNQ7GwhRiOf+LWkg==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr21767861ljj.184.1557325489941;
        Wed, 08 May 2019 07:24:49 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v26sm2991939ljh.11.2019.05.08.07.24.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:24:49 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/1] mesh: Use node uuids as storage directory names
Date:   Wed,  8 May 2019 16:24:44 +0200
Message-Id: <20190508142445.4508-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of the patch drops direct asprintf() calls in favor of
l_strdup_printf.

Michał Lowas-Rzechonek (1):
  mesh: Use node uuids as storage directory names

 doc/mesh-api.txt | 26 ++++++++++---
 mesh/README      |  7 ++--
 mesh/mesh-db.c   |  4 --
 mesh/mesh-db.h   |  1 -
 mesh/mesh.c      |  7 ++++
 mesh/node.c      | 38 ++++++-------------
 mesh/node.h      |  2 +-
 mesh/storage.c   | 96 +++++++++++++++---------------------------------
 8 files changed, 72 insertions(+), 109 deletions(-)

-- 
2.19.1


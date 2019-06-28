Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168CC4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB4208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="kW4Z4dz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF1MwO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:52:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37084 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1MwN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 08:52:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so6183339wrr.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLuXkzUices8D2d388aMEWPr32CuSdLcBE44Cn2waZU=;
        b=kW4Z4dz3jBdsHPM/J1KeG1ptYdmn0AUIig/PPvg5j7PP3Xb2tVUjwAyJaRB3k2ULsk
         DP7Yxz7Hix+fQjIahc2v4OVNklbsTziVVQQsWgrNsQTbcIV7UiKw2C7SrsSGyv6B2nFt
         02OtGmxQj3Gf1q3P7bFsNvkx+/6ET1z8SPaP2AHHEJ6qJkmd8KE4aNisPXCywvehryrl
         pJdUXAtwFiOHhUGnGeU4T6k7LRTpqTPD/7EaxwsULGJI0KtLq57hSTH+/Kc0ErYj9IyQ
         cOAHkXaIf9GQmC8lBeGO8S0OjNscgsC+Jk+DlINgmAskifpuNmvigtTC6VkS6ADTbqhb
         D8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLuXkzUices8D2d388aMEWPr32CuSdLcBE44Cn2waZU=;
        b=Lzah2uUn/t+9sN42LQrwwX0EqE0lNyVuVhvl1cn9zkaz1bhCMLBxqI0AWkDZgVTB9+
         7AEWvgcXaDlvtypX/C/S3CE0ipMzxRqLgtZbOXDqITZYtNuF4mhUPKMY/n7ofn6JLmrk
         Pl0+YeVW5lWs05aEvGwzqpsTYSNre16EPMpwG+S7WgDpGITfE7kw2lSq5l00KxvSKUCO
         OeKs71TBdrTjk381OWu7SXWMV2Z8j7DxU0AIXlZAI2nGfZOW/MIwnBtg8dsBLxyParZ4
         bHQGN5vN2g/pRS1BXYsdyBNjDVoSfZS17kQkIhMsVP3XdkUai3GhcNXH9K5T9mNQ5fKG
         S4mw==
X-Gm-Message-State: APjAAAX0jdTG+w99gCVE32PCtkFU289JzMq7T/UmL+H9zpNBEhBP93yO
        R981f1+UZS7T+hEB7/Ph/iIjZKJjcL8=
X-Google-Smtp-Source: APXvYqw7bFZbGhaFR51RidJxRSXBORz0bhAawdOSQKmyoi/gzcaAebPUXcrxNUTi1Po3a+urzWvf/Q==
X-Received: by 2002:adf:b605:: with SMTP id f5mr8278469wre.305.1561726331402;
        Fri, 28 Jun 2019 05:52:11 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y6sm2226484wmd.16.2019.06.28.05.52.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:52:10 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] Add support for remote dev keys
Date:   Fri, 28 Jun 2019 14:52:02 +0200
Message-Id: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset adds ability to exchange messages with remote nodes using
known device keys.

Michał Lowas-Rzechonek (3):
  mesh: Rename APP_IDX_DEV to APP_IDX_DEV_LOCAL, add APP_IDX_DEV_REMOTE
  mesh: Add DevKeySend call
  mesh: Handle messages encrypted with a remote dev key

 mesh/cfgmod-server.c | 14 ++++++-------
 mesh/model.c         | 41 +++++++++++++++++++++++++++---------
 mesh/net.h           | 10 +++++----
 mesh/node.c          | 49 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 21 deletions(-)

-- 
2.19.1


Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECAC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9C62068E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cjBCh9gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfKZOyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:54:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38590 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 09:54:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so14342205lfa.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRO8xtnmYKdtUJ9c/POE1IA+LM2yq72+9+Cu/TCPkuY=;
        b=cjBCh9gqcivWiSCL7GPUJ0vBX7PTQ+hI3UuUaHsrNvipfc2q4ZL4aUUpA2tA804i7x
         rVweupSbVEEl6qaluDvK7YA+XExI7lixhbmVjbVzQHp3K+xkjv6J6SeDnJwEkDExtMAa
         jDDmGs2jDBZweWUZ+cuVDnV9grPPne7r5yBKZts5r330ST31LhIlYpwyuXNqZ+c1vn8/
         IvLKWF49L9PULhHkNKhY9ICVTW1K4vDuU/yZhitOJ0BRv2FG2NhL5MLqVsKPplnPTKNj
         5p4saxoLwDPXTaX1gFl/yY44i8dHSyAcCGZecKtrzDtuBxK6xHjqgESa+GBeeFMFxKXJ
         nJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRO8xtnmYKdtUJ9c/POE1IA+LM2yq72+9+Cu/TCPkuY=;
        b=M9o6GSFthafMi/e8Yq3hzL76FDafcVAPXoHmV0dwB0E34w2sYdxW2+yyNR95k8sGsF
         0csP2JqH29MhAbsJqRkuCtMwxHUv7CytblMO8s/uhJ/3Ar9D2mKc0ze3hdgZ9puRL+kC
         2qBc86NIhP+FI8WC2t5R2kbOJaXDZuuBPUFBhD/RBabKWBGQ3qurAWBmfUy2WnrcazQ6
         Kgcktwh2GFlFqiez90jHAMvh34Ru63IK+36oA/BhbK9uOxrVz9G5uv/bQPu4h8N/g1QZ
         3nlumF0+ioOOsErDk+cm+MVjctM3yI60u93lq8S+ZvpKJABy0DXfj3z5o2uyGo0RwiK/
         N3gw==
X-Gm-Message-State: APjAAAUGSfOVIDQdeZxUKDPS2VMUh6mWiyWrs8HHmBONx5gA5xtY9drD
        0HKfFWaApiOA4lJGKXyxzpWRhh/qTMy2/w==
X-Google-Smtp-Source: APXvYqxOe3NjlPE/s0QoTEWL63ziIf3ylxh5YPUlsFBVocud/NmdnUG5n874PYPcko9dzQ0PA3ta9Q==
X-Received: by 2002:a19:9149:: with SMTP id y9mr26009589lfj.15.1574780048644;
        Tue, 26 Nov 2019 06:54:08 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d26sm6607954ljo.54.2019.11.26.06.54.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:54:07 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/3] Include destination address in MessageReceived API
Date:   Tue, 26 Nov 2019 15:53:58 +0100
Message-Id: <20191126145401.25129-1-michal.lowas-rzechonek@silvair.com>
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

v2:
 - fix API in test-join
 - display model subscriptions in test-join and test-mesh

v3:
 - style fixes
 - when adding subscriptions, call UpdateModelConfiguration after subs
   are updated, not before

Michał Lowas-Rzechonek (3):
  mesh: Fix test-join to include mandatory VendorModels property
  mesh: Provide destination address in MessageReceived API
  mesh: Inform application about model subscriptions

 doc/mesh-api.txt |  32 +++++++++++---
 mesh/model.c     | 113 ++++++++++++++++++++++++++++++++++++++++++++---
 test/test-join   |  37 +++++++++++++---
 test/test-mesh   |  33 +++++++-------
 4 files changed, 184 insertions(+), 31 deletions(-)

-- 
2.19.1


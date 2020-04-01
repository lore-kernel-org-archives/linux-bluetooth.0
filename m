Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFEAC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247B320678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="DRmjW/1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgDAKY5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:24:57 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46908 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbgDAKY5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 06:24:57 -0400
Received: by mail-lf1-f44.google.com with SMTP id q5so19957157lfb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFtJxF/U9jAwX3R94DKfhRYSc00tKtQhaoXDdT6kVdk=;
        b=DRmjW/1SY9xXwst3yNm/aBi4weAYA9xg0ryKWK91uhT1wIPsdv4vGHoJoI7+SaWSLu
         w05ocC0e1vQnIAQAPS1gpT1K4/zmH7o4YEAEwZ8yUgBaisZa+i5QxZR+fk7jkatAlcBJ
         SUt6wW8xoFljSV89/HXGTYpMOGfQ9cqDN1gwzRk4+DsGiMYEhfVcRXOp0Gokz8ARvlZW
         /acOySxbfE9QieBj21Pf5gM7M4ao138gQwk88cNV+D08D/sb6ofP9XuOuf6wwhQTYWbN
         9PJdVR/sdw0976kuZ+YGBg+bKFueMctv7teQt+YKeNKFX+INmY4cxKV5Njio3IhpDjX1
         +28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFtJxF/U9jAwX3R94DKfhRYSc00tKtQhaoXDdT6kVdk=;
        b=k0sEc41xa1tIpOHLs2TZMjEZ9qrGStCCwP1eIfZdriOzlzY/hjMRbJ+zNAiflmUCfS
         zgzbqrHLn+YFH9CXfspAzDyTL0rEwGeq3psdu5wOaQrv+Ri1xcD7RM2JxPaPBHS1TBCU
         3ZGoXRmGuuFiIrffa5AYey9jc2PR+3OaIOkIeM9UWckwmUCq803S6jUk6wwb4ujFonu8
         C+sRcQEmboHBgNIV7hnuCaE4uhXRWyHVr8q7OCs8yZxt7YpLo8vhTV9RkVAavha+8uKd
         dpBNVn8ejJ6UGyDxG0C/r8lx7svd0B/1jO/PBzJi9CRChj9sSpHs8S88q/cLqVKucHiK
         GNKg==
X-Gm-Message-State: AGi0Puaiqq95nP3zvYLQ/BazQr1jr+eWhsOMqf6OeRG2k4ihrDQIPUp/
        k/UXGprvkX3orF4EFernePqnV3gOFNQ=
X-Google-Smtp-Source: APiQypLPzq0BoDwovpkxfCV0dlXA+Wg3yzqt0oQ0xgQyyOyntSBgv696dQvTQ5zRtDoXBJcZXswjnQ==
X-Received: by 2002:a19:844f:: with SMTP id g76mr14055809lfd.112.1585736694806;
        Wed, 01 Apr 2020 03:24:54 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r16sm922217ljj.40.2020.04.01.03.24.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:24:54 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/6] Honor provisioner's capabilities during authentication
Date:   Wed,  1 Apr 2020 12:24:56 +0200
Message-Id: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds ability for the provisioner application to declare a set
of supported authentication methods via ProvisionAgent1 API. The daemon
will then select the most secure method available on both ends.

This fixes an issue where nodes declaring OOB public key availability
could not be provisioned by applications lacking means to obtain such
keys.

v2:
 - fixed memory leak when displaying OOB data in cfgclient
 - fixed action bitmask endianness between mesh_agent_prov_caps and
   mesh_net_prov_caps

Michał Lowas-Rzechonek (6):
  tools/mesh-cfgclient: Display unprovisioned OOB data
  mesh: Remove unused 'server' argument
  mesh: Clean up naming of provisioning callbacks
  mesh: Refresh provisioner's capabilities
  mesh: Honor provisioner's capabilities
  doc/mesh-api: OOB Information field is 16 bit, not 32

 doc/mesh-api.txt       |   2 +-
 mesh/agent.c           | 105 ++++++++++++++++++++++++-----
 mesh/agent.h           |   2 +
 mesh/manager.c         |  33 ++++++---
 mesh/prov-initiator.c  | 148 +++++++++++++++++++++++++++--------------
 mesh/provision.h       |   6 +-
 tools/mesh-cfgclient.c |  20 ++++++
 7 files changed, 236 insertions(+), 80 deletions(-)

-- 
2.20.1


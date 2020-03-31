Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BDCC2D0EE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AC820848
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="RCLlCYZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCaI2F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52557 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaI2E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so348753wmi.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvkcZLb0lo48Z4SJcR3PUEwietXVioWin8LEMOg0uxg=;
        b=RCLlCYZrtHnynHJdOb/3G/CL9LKdENl5ItXP9Q6QIhlLz4Qx2xtPwZ5YW8x3xynaXF
         rQ4LAv9kwG9odDyPXWXBKm5UmfE2U1XVnksvvHLGKgTLtOGT5ExDEkinpejScE9tqbbP
         kV6tJcR7OiyCIzTtyCx2lws2TPZfLFH801t1ze+5lBqH/980bu3EgRHlabn/iAFNYv2m
         ghCcnq7zlsBUKLu36tD42/vy92aNpAcFjr+AkDe6S6oXu7dTeoWB7dc2/wj6tgKwJ4er
         jFTWtUlsGTtLCvxPv6KJVaQoFm5QGKIw6Ltul9zj6LPwWeBim7WXljwkkktn1rdC+S6F
         gnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvkcZLb0lo48Z4SJcR3PUEwietXVioWin8LEMOg0uxg=;
        b=TOLbAj1PP0ZffaXnfXIC5f56eM2Q8+O3ed4mPgri1iaUtqk1B2XxFiiUS5LS6d+yh2
         vpaqWOwzAilLBVu+4FyA8eCgWkEXXkQN4v3pFN2D1d2s9HfrvZ9SB47y3n1HlJwq9HKN
         SGNhsx/6C/65UwPQ+r6RjBTdZMnxvuilUCFiR/K0Yf510NYzNsJmQfekkuei8D0ZnEtF
         Qd5/x1WMPakX/a5yHhJWe4Kb1er0u5b3chvO7QAJh7v4mU2FmP1IQvIYwTpQCeTenRSF
         RXxoBqnFwbU79qOatGsNGzRt1C8xqlWh/faobYRsjj4/zOmtcvTjqvEDlbSVaNHamBsX
         k9Qg==
X-Gm-Message-State: ANhLgQ3WgijH4fExAlu2K7Qlc4Rnz8gxtazH0gSKoy/G6kJ28sbMbnYA
        qiwwdF5O5lZbuCep1cGNvTIxLaRfaLsFPA==
X-Google-Smtp-Source: ADFU+vsmqF/Qb8SgppEvK5tFTk4jJBtD2EvjB00pdB4mqwGf1YqE7tbsQheUjNZx7WaNjWsr5ABf1A==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr2292987wmf.85.1585643282373;
        Tue, 31 Mar 2020 01:28:02 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:01 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/6] Honor provisioner's capabilities during authentication
Date:   Tue, 31 Mar 2020 10:28:04 +0200
Message-Id: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
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
 tools/mesh-cfgclient.c |  18 +++++
 7 files changed, 234 insertions(+), 80 deletions(-)

-- 
2.20.1


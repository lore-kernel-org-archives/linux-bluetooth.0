Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A3FC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516F20678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="eEHjJFAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgDAKZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:25:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43922 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgDAKZA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id n20so19940437lfl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b96my60rfsHxPwOWqECXE04G4E9wJo6N/lPNkbAIU84=;
        b=eEHjJFAm9aVQA5JGQgCM5e6Ab1TShwgElP0ltmvtWh3m0vViD1sDALS3P/CVDNm0kw
         jeKgFppzcVQEBWUHLmvQ38Lju4bBaRzEX5/mnqBe5TIYz7rf2fyJZD26kLkfDmBkA9OK
         LRDqqPWvkfVuiMV5I9OXZO1BXQk0/jj2shA9QEe0DGoR+BpVdHma9radLY/H/u4hZ304
         T4OuGH4bTBIlBYpQx/BX4rKwioCbHtCsJAXB4bDjymmm00EtZJVZDAtqpSH0K7MSmPWE
         o4x9uOl55UAbpW9q02YofwMqV1jhsbkm5dm7CV1IckioLseBccRx7uzpZFK+nPVm3zDD
         E1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b96my60rfsHxPwOWqECXE04G4E9wJo6N/lPNkbAIU84=;
        b=JIqxfTTcDZFE++qN5idicZZleGf19fwMCk3cDuBI/hnUmVYPViT4uqrZyN91j+KmCH
         yglo8ZpMQh89dGAb9UqhtU+ha0PLklVF2OPD53fOiMfib/Jwu5mo8ntXSSs552Eo26CM
         yzDp4l/u3SCyCs4rqJV8Jl/nrRj9kIyASnfkEgUs2/hSVPvGcjmIKn7dUNMm9mN+9o8x
         XuHgOMqQPMmZdX3GNdTEIapM1I7PEOSeU262AWe4HcUQWyA6Dk2n3fICyX0m3PP1Hk0i
         KDXr/J1rjmdZtSviBd7rJ4sQ3G8HDVL3K32z4rA7cwqGuEUxM1xrJ3v0H0zYaC2MUG/e
         9GMQ==
X-Gm-Message-State: AGi0PuYcr/TP9WMFEm84FS4D/ohIJ6BKP1vtS1HjbWJVlClM5QH6UYWP
        LfvGLXd46zihvSOyHegToqB4CzVeuWE=
X-Google-Smtp-Source: APiQypLy2b3mL3x9FVv4qP4fLMBtQ8qZrzD9OwSARKIodr6MI8BANPAV1/3FghqC9fUKjTTjOv2lsA==
X-Received: by 2002:ac2:51c5:: with SMTP id u5mr14068050lfm.151.1585736697265;
        Wed, 01 Apr 2020 03:24:57 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r16sm922217ljj.40.2020.04.01.03.24.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:24:56 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] tools/mesh-cfgclient: Display unprovisioned OOB data
Date:   Wed,  1 Apr 2020 12:24:57 +0200
Message-Id: <20200401102502.746-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
References: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-cfgclient.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index ae13c4409..43588852b 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1533,6 +1533,19 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
 	l_free(str);
 
+	if (n >= 18) {
+		str = l_util_hexstring_upper(prov_data + 16, 2);
+		bt_shell_printf("\t" COLOR_GREEN "OOB = %s\n" COLOR_OFF, str);
+		l_free(str);
+	}
+
+	if (n >= 22) {
+		str = l_util_hexstring_upper(prov_data + 18, 4);
+		bt_shell_printf("\t" COLOR_GREEN "URI Hash = %s\n" COLOR_OFF,
+									str);
+		l_free(str);
+	}
+
 	/* TODO: Handle the rest of provisioning data if present */
 
 	dev = l_queue_find(devices, match_device_uuid, prov_data);
-- 
2.20.1


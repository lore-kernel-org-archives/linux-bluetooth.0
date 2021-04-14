Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E640AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 04:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF03A613B1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 04:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhDNEjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 00:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhDNEjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 00:39:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D995C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 21:38:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso10171307pje.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 21:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TwUbW/pECTDb5WDMpp9WpHC3zvBUy8L/8SBV7q/KxsQ=;
        b=UHFWLDok1hSQN9pyrHmsJG9kNDu0UWIFZIb/tN4EKDgJ/JO6mue/Gw7CAqyebcBZ0E
         AZQHs/vm2kh+Xu3hSte9hB1zXsXVrFgNbbNUtKeGbZ1x60169SMqPU169UCGx9s4lGKy
         mZLs4QxKHLnNNE/CLLDISxPsKp137w5zeJwcIZPBsCFKwq1Yq9q8fMLSkAgC9qQ9+tGv
         /tdCsl/yvZikQfadJ4D3GjvLYumyUJEXWd93wbzCPq9b8v8zfrVHjR5JLSzGg8vCFUAz
         j1YuOYqqpQNbe4o2K+8pB6R4zaGphj3rqW+/HAYBVME+gXgiTuXdWTG3YQABhdkKrqKB
         Evug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwUbW/pECTDb5WDMpp9WpHC3zvBUy8L/8SBV7q/KxsQ=;
        b=eJO9MY2rKCfsglFdWXoqaIA+gSjHYGsXOSLynjoPvsyJOBL4lTV7GLQ4BUm8GggYn4
         ds5nDMd/uprjIv5mvNIKeBR+Amwf2bSfDJasf7fXIEBaSc9lvOlCr5tNhUXVXZnaw3KI
         1+QtCnYdXBANP/Ntp13R4+ScC+4n5Pn6vDn/qvRFKW9eeAMfIcGIn+/o4pQ9rPN1bOaA
         JBOdJWsCMO/C75sseGWKcIuSkRBAEeW0o+cBqTs7ZbcnDyfhkJVDKtUtniC82aIA6wCy
         b4zhDXHwsA9Tobi6KCRjCpWhC/erKsbgNMA+wKxY89kgbckGeh4dpYUjiPZjE2PjwFSG
         HkLQ==
X-Gm-Message-State: AOAM5329Hp5kFhHJz7ZKmtWPF3Xwt6NTTO3xx9f055ZbunFobVYiaQ1C
        8TrjUBswYiXa5dfNt9CTKSdVsXV6UVM=
X-Google-Smtp-Source: ABdhPJyQ7Dqgu8GQVFxlb4s+dKW0g4ltnB+oSJgs/iycDB1f1JpM7LDstJiFsGbxyWohv7aOJJff/Q==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr35004424pln.70.1618375138674;
        Tue, 13 Apr 2021 21:38:58 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:fce3:33ef:352a:9b19])
        by smtp.gmail.com with ESMTPSA id d6sm3118986pji.43.2021.04.13.21.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 21:38:58 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [BlueZ] monitor: Fix the incorrect vendor name
Date:   Tue, 13 Apr 2021 21:38:57 -0700
Message-Id: <20210414043857.371176-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Tedd Ho-Jeong An <tedd.an@intel.com>
References: <Tedd Ho-Jeong An <tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the vendor name is alwasy shown as "Microsoft" even
though a different vendor.

< HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
        Type: Data fragment (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      Microsoft Secure Send (0x3f|0x0009) ncmd 31
        Status: Success (0x00)
---
 monitor/packet.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d729a01cc..91d2294ff 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9325,18 +9325,12 @@ static const char *get_supported_command(int bit)
 
 static const char *current_vendor_str(void)
 {
-	uint16_t manufacturer, msft_opcode;
+	uint16_t manufacturer;
 
-	if (index_current < MAX_INDEX) {
+	if (index_current < MAX_INDEX)
 		manufacturer = index_list[index_current].manufacturer;
-		msft_opcode = index_list[index_current].msft_opcode;
-	} else {
+	else
 		manufacturer = fallback_manufacturer;
-		msft_opcode = BT_HCI_CMD_NOP;
-	}
-
-	if (msft_opcode != BT_HCI_CMD_NOP)
-		return "Microsoft";
 
 	switch (manufacturer) {
 	case 2:
-- 
2.25.1


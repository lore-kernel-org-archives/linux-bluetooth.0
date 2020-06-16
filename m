Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8034C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FB5207E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 05:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O3GU3H4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFPF4u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPF4t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 01:56:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A8C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 22:56:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u8so939155pje.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XTshnA7BR3B2kzepDrQGoX5KjoJhidKH0c8vEqbQtU=;
        b=O3GU3H4CqRveYWVVYGO0pNkDJiMjzILx/KxS8Z5Z4lvDkOajz2id+FmewRTiSzKO99
         Q/BuKTmwFh8FonXeFS67cMrJ8gg6F0NFkv0fNWmPJlEPz44j7eMfsF+2dDXw+S/bCYys
         qG97GMkTxB+bu4oieC14YYaYZ2icm+R4tl5cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XTshnA7BR3B2kzepDrQGoX5KjoJhidKH0c8vEqbQtU=;
        b=uAHh1wBo5519s2xB11Pr6SdEiEDc/B1+Rzfwr7goN5CBAVtGR2uNxKq/ApyoUYOy69
         MAhIs3GybRtfGGUwQjy9Ubqf2qOGiLKJMHhSgHtKwWCkPXZyhjI0E2iXDaFFQHvXaPDO
         EDKfsplLSfGOVCw2mLXKdIVYxzspGPUyeujjPbSZkmK1fM+C7tngo4EwbftVGiBRu26H
         ZTlyxkJfEgo3OL1sDwKVe+c/Z/pqLQ9sJUs4yDg7d/Z6BlN2Hce+y96/YcJUDGc4+ctp
         33FHqVvRleNFFgE0XoVEQIjEN6J+liBrvnNIY0ru/LuxpnCCFe4N5hsHc164mMMPJexu
         NURg==
X-Gm-Message-State: AOAM532ExK89TkWxfb99k4ie5mBXOmiSIZt5qcHGFJ1t8L+hLQQWgOTE
        OxcHaa0lGMOVyHYVtV2jmadSG62gZCU=
X-Google-Smtp-Source: ABdhPJwIsK3e9+VnenZDtMH0uAJ56xk0Bu3StkZpDNHCw6zjxf8F5L66Ru8ULo9lFRwxlaRKBfCLgQ==
X-Received: by 2002:a17:90a:36cf:: with SMTP id t73mr1516015pjb.100.1592287006742;
        Mon, 15 Jun 2020 22:56:46 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id s23sm1176456pju.35.2020.06.15.22.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 22:56:45 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] lib: Correct def of Add Advertisement Patterns Monitor Command
Date:   Mon, 15 Jun 2020 22:56:41 -0700
Message-Id: <20200615225619.BlueZ.v2.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 lib/mgmt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f44f2465d..bb31156ab 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -673,7 +673,7 @@ struct mgmt_adv_pattern {
 	uint8_t value[31];
 } __packed;
 
-#define MGMT_OP_ADD_ADV_MONITOR			0x0052
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
 struct mgmt_cp_add_adv_monitor {
 	uint8_t pattern_count;
 	struct mgmt_adv_pattern patterns[0];
-- 
2.26.2


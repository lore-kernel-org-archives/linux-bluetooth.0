Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF65C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 04:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21EA20707
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 04:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGMLBKRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFPE2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPE2k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 00:28:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69223C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 21:28:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e9so8633164pgo.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XTshnA7BR3B2kzepDrQGoX5KjoJhidKH0c8vEqbQtU=;
        b=UGMLBKRVUL6Fs/ZlMascYH3BjfXIQQJRxZZ1i485i+/aASXMcDNtg6ySyUJxUXzVWs
         7i/nzvAingF4VRZbrZX71n642pB8ZGeyRLNHSu+SBgu19aV0qooKiZLIq5+Dpn6q5ban
         A6xcP2HM+Q5uSisIdEQ+aoLDfLs5Wt/bJorqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XTshnA7BR3B2kzepDrQGoX5KjoJhidKH0c8vEqbQtU=;
        b=N3ejOc/VjyasRgsMuvPQEdRmVw5Ac2yXCztDtPfhTbLVx7Er3+7MASvmGnqS4G4Yfz
         gFFynrQLkBgiwEsNI2ohEOj6mhkNWnZN3jtd4uSBrgEMO1kO6pkORnZoQD0UAt0bA0E/
         LJQ/Eiu5lzWuCWKtX1I/hldKGRX+W4NCgm6Y7lfzSAzcTNpR1yeziTcmlW+9CY2uUzmu
         jLYYlx1aefNfQrEl+OLPku3sEEvORTEYmYExHjNuOQbpvC8MU9OTkUbiCs64BvhJw3QR
         iZWLWDZyozWGJDbPjXUk6iAhokfLkCM65XD2ibO6omuuS/pWCsk8zm8Qk4H0vdWShhxb
         SrNQ==
X-Gm-Message-State: AOAM530Z0HqOYR7ODS1zQVqpeRtLrdyD9BIERlXq0wOQh8rXrEd6jmh1
        ePXJbt2iRdI2ibPFWaisMb1GOaJEcfM=
X-Google-Smtp-Source: ABdhPJxWwVeNi6T7kU/pymkp3b/m2ik+NY2vMKXghz+UVKsyDbClNU76JNFLONBHovKyejdzx0cDLQ==
X-Received: by 2002:a63:f413:: with SMTP id g19mr637523pgi.200.1592281719603;
        Mon, 15 Jun 2020 21:28:39 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id y6sm16010851pfp.144.2020.06.15.21.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 21:28:38 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] lib: Correct the name of Add Advertisement Patterns Monitor Command opcode
Date:   Mon, 15 Jun 2020 21:28:34 -0700
Message-Id: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
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


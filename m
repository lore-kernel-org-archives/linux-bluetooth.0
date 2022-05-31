Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE9CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiEaUzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbiEaUzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:55:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E39D06F
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:14 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b11so10488898ilr.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=HZXAqCNcl+5cIjSP70jwrhisfxZcpdsUATNsCmVWsZHYMhvLUaOHvWQygN3yX9MULR
         RCKna7ywAvQRQbJZUj+vJtOvlF7jL2pqV1nukQXGeg0kowQTtkkdijwitt1zK8+grh8I
         SVul3b14UnsUBChFhQk68EJ6epdgEl29t3hb76RupiWvj16MNs3tIzY9pt3xWmT50UcS
         CE4Yw4Jr3Q+OHU5jitxvoUKBZ788GXfzuIw/ZO201UU1bcc/Ao5JdiaEsYESdSDGFovB
         EyWVdB/q7yNLXQ+URS5Pw2DiLTnuDfIIPO2dZFrN0Sx5amZE0G76m7qQXd+wiaPBrLpM
         NXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=hpSpbSlXVcr5PC/KkVhPzf8F/I1A6xD/hWObFHthtNJ9tBOQ6ruQ/f6vMWUdzn9+tp
         HoF4vnzngU/Deh5ZHomer702oTligN9qIOdq2g78k/4dTBK3fr4wuDxMQiSSuRAgipzp
         FiBCGJ8DIDTrRO2At8TuwXxDM9V/VZWjvHzzRlSwjmCYER6SkdpSttNoqSO/ePNzQ+GD
         ZDQIq5umGLoewxKgSpSNmhx0yTWBWh0quSFh7xebV6E/494GM3voWplDru5HjEAA1TjY
         XQGQAMVdw42MtWWSSxXGeVm6fsv0OAcwdSCK7uMrN7LbusZbSHRotHtxAF/Hyv7/Wpg7
         n7OQ==
X-Gm-Message-State: AOAM533qw2kcTbi49HB5a6RUE/qafbAXRJBYDI8dL3jyLZGzR7g6ggAB
        I5xPLaZy0UlsLXmZRNmCr9JnS0kVTOc=
X-Google-Smtp-Source: ABdhPJyTAbxZfQ3vUH/2K9x6MymSX/IDFXl3V81fkXJf4Tn653C0D4WUSB79g6OC0k93KCrUMrAvTA==
X-Received: by 2002:a92:330b:0:b0:2d1:e2f5:ca47 with SMTP id a11-20020a92330b000000b002d1e2f5ca47mr16933395ilf.66.1654030513876;
        Tue, 31 May 2022 13:55:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a922e01000000b002d10dc367a1sm4808460ile.49.2022.05.31.13.55.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:55:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Tue, 31 May 2022 13:55:04 -0700
Message-Id: <20220531205509.1062466-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531205509.1062466-1-luiz.dentz@gmail.com>
References: <20220531205509.1062466-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO Socket UUID as response to Read Exp Feature.
---
 tools/mgmt-tester.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e5319d123..bfa5905e0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9798,7 +9798,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9810,7 +9810,11 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x00, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
@@ -9822,11 +9826,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x01, 0x00,				/* Feature Count */
+	0x02, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.35.1


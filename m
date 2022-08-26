Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0DAC0502A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbiHZXUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345494AbiHZXUi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B4B6012
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so2544075pfw.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=G5cwwTDmLKgQ06i6iT3eCdA8rIblVxOtAFmpHxMA/bPZiE5iLd/aHbkjAR4GSptVZK
         ZgtVUIBgP8WZqunQXnl22zjF3YRtj6QvpFHNlqfVQo1wvg5BOSN5EDRUc0p3MDIg1YYA
         KrSXAa8aKqUJBbmfLxmyFjqinWgyzbw2fiMuJBwt6a3+binZjGa1OxaTx2+WK6XAyozF
         05u0tR7nhnrsU8Qtb+FZo8ko9tIAgOXtA5o91R2wU6e/LX19IoZwGJX8rHDMWymewMLl
         ki42WxU4CSJI3XL4GdJ0IgncPdam+wNo64jVpv1MZJ6TeLnsCMjAW22cgeBXKVrhdanY
         5c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=eucxAGhLPGxVFO2Il5iBinE2QnnktuPE5xuOoJn6bcMI/myl1i7m7KTL9hD0mKuAwh
         Vn52OV2zqTQGEVBcKSjtrwVMqVRSU3azJfF9PMK3vRvEIdLO0Psw6I5swmBueMP2xSEx
         +uqmLD6O09iJAyJjyYzsJRdKbE9pQsUXmxyrWMXIf9HenOiC5Bt0vBwz9RwUc+KnSPUH
         dCyZJ/+A4wnoqEgdFN2ljH4daxuP/lz87wqu41zJsdWSBKuUL2nEQB3ZSAZQBe3nNuLo
         Bsvg4VaryfDWx4IWXDhCWuBahTLTiXRF9tiKy4MW2vPSvEKfcvPWwFGuSkOsVV5yRsKB
         xGFw==
X-Gm-Message-State: ACgBeo1P1tabLZYAgAzovvFFRrv7OjPpi52GHGIBzBFdhmeZ4Mx86QLC
        DA92Q/N6aeTKFL9S4o0VTdC10zzFX/Q=
X-Google-Smtp-Source: AA6agR4ucJ9r36NlEMXwpRJNZyP0lx4uPDHswnvPQDwPFRKfLnIJWmuBijQfExcMjQaGUUZPZP+eLw==
X-Received: by 2002:a63:8048:0:b0:42b:73ef:ac8f with SMTP id j69-20020a638048000000b0042b73efac8fmr4332719pgd.446.1661556036443;
        Fri, 26 Aug 2022 16:20:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/9] lib/uuid: Add PACS/ASCS UUIDs
Date:   Fri, 26 Aug 2022 16:20:24 -0700
Message-Id: <20220826232031.20391-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PACS/ASCS UUIDs which will be used by Basic Audio Profile.
---
 lib/uuid.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 6236752a17a6..cb9294be8c6e 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -146,6 +146,24 @@ extern "C" {
 /* GATT Server Supported features */
 #define GATT_CHARAC_SERVER_FEAT				0x2B3A
 
+/* TODO: Update these on final UUID is given */
+#define PACS_UUID					0x1850
+#define PAC_SINK_CHRC_UUID				0x2bc9
+#define PAC_SINK_UUID		"00002bc9-0000-1000-8000-00805f9b34fb"
+#define PAC_SINK_LOC_CHRC_UUID				0x2bca
+
+#define PAC_SOURCE_CHRC_UUID				0x2bcb
+#define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
+#define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
+
+#define PAC_CONTEXT					0x2bcd
+#define PAC_SUPPORTED_CONTEXT				0x2bce
+
+#define ASCS_UUID					0x184e
+#define ASE_SINK_UUID					0x2bc4
+#define ASE_SOURCE_UUID					0x2bc5
+#define ASE_CP_UUID					0x2bc6
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.37.2


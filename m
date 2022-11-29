Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A02C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiK2UqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiK2UqA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5072657A
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:45:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d18so3817486pls.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIuN04fzi/QvqGgsYhrpXfuUt7W+BqBRJCjrS+p5YYk=;
        b=iIS4kkzvcBoxVff78BFcY/TwsdgCr+SA1YI2noHW5DTgxfF7vLB6gasNTfU6E9OtZ8
         bSjV2AKmL7DPqDqce9lOZgiG9kP9PseLTjkoMV7zi2DIbf6gqNmAOQ2tcDhkcNlwHBQM
         Fye82Edb3s74nqDHL4LcEgWzVRw8nYNg4WSJD5897GpFfv2I8AKYA1I9YYwtW7yT8VCs
         yUjVu0714Zwm/luY3zrt39nX79ubmpvSkNZ5hykih/cXLpE5vcYIQNktW7UwH65aBcb4
         r6q3Cxtd0dF8I8RpHO/YpN9NY1HgbcJa8cdxFogiw4gMANmKNwNtcABfPvyAw/pFfBDq
         PJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIuN04fzi/QvqGgsYhrpXfuUt7W+BqBRJCjrS+p5YYk=;
        b=qeH19kTUS+eQHQIfc224gci6lo6El4ssP05O8Nw37sRaoPmfP65NAg0Nb21Cxy3K2q
         uWHQ/XUY0k+ERzNy376n+AOAAmwjgPdfY66MDmDyIG4lDG1d7EwYNv5uOCIK/0LSFZBe
         9cksbk0RiM3QU9FEzj7yLsxe8t3trsCAO+FGfDbVJntaRvozJiqH/O5SlmWsGNNuPpHz
         sONd1m0hZJV5Q+4BR1tAOSMyvNoqm6+v1IuqGngthK0zBiR4n0Sk22YszS+g4kIT7zcq
         9IAronPWekKCZSibGDKLtiKqWBlCiSJFMLUjnRt0kIpQoyKpk2Q7wH7dfp6BoKnzo5VD
         14ng==
X-Gm-Message-State: ANoB5pkmKOfevY30w8PYSS1pw7j33DLgYYLGRxRqkBkkj/bT5toZHqhs
        2J6cCxR14nB+dn/ESywNfSifxEsOsA77BA==
X-Google-Smtp-Source: AA0mqf7W527+rOn/359y1zjNHOBSqnvnPmcYCkTbODDxoxfpGlJr3EWqC/XhnY6ggLMeqEhJ+VJfsw==
X-Received: by 2002:a17:902:ce90:b0:186:ab02:664c with SMTP id f16-20020a170902ce9000b00186ab02664cmr40647183plg.49.1669754758447;
        Tue, 29 Nov 2022 12:45:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm11216214plr.257.2022.11.29.12.45.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:45:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/bap: Fix not reading all instances of PAC Sinks/Sources
Date:   Tue, 29 Nov 2022 12:45:52 -0800
Message-Id: <20221129204556.1535821-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both PAC Sink and Source are allowed to have multiple instances:

 - The server wanted to support a smaller maximum transmission unit
 (ATT_MTU, as defined in Volume 3, Part F, Section 3.2.8 in [2]) size.
 Exposing all supported PAC records in a single Sink PAC characteristic
 would require the server to increase its supported Maximum
 Transmission Unit (MTU) size to a value the server considered
 excessive.
 - The server wanted to expose support for proprietary audio
 capabilities (such as vendor-specific audio codecs, as denoted by the
 Codec_ID parameter value) separately from support for
 non-vendor-specific audio capabilities and used separate Sink PAC
 characteristics to expose such support.
 - The server wanted to minimize the amount of data to be transferred,
 when sending notifications to a client that the Sink PAC
 characteristic value changed, by exposing the audio capabilities
 likely to change quicker than others in separate Sink PAC
 characteristics.
---
 src/shared/bap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 21aa8aa6c5ca..7a24824a71fc 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2908,10 +2908,12 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(bap, "Sink PAC found: handle 0x%04x", value_handle);
 
 		pacs = bap_get_pacs(bap);
-		if (!pacs || pacs->sink)
+		if (!pacs)
 			return;
 
-		pacs->sink = attr;
+		if (!pacs->sink)
+			pacs->sink = attr;
+
 		bap_read_value(bap, value_handle, read_sink_pac, bap);
 	}
 
@@ -2919,10 +2921,12 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(bap, "Source PAC found: handle 0x%04x", value_handle);
 
 		pacs = bap_get_pacs(bap);
-		if (!pacs || pacs->source)
+		if (!pacs)
 			return;
 
-		pacs->source = attr;
+		if (!pacs->source)
+			pacs->source = attr;
+
 		bap_read_value(bap, value_handle, read_source_pac, NULL);
 	}
 
-- 
2.37.3


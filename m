Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5029C77B60
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 23:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjC2XZn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjC2XZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 19:25:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6547E1BCD
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 16:25:40 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n28so3146712ioz.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680132339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5gAEQBgCAmrDCYhK9Tm1iY+TdGfsp+0qEGPnEFs/eo=;
        b=OPVN7SJfeYkgO3QYAWN7OiHcEXNHXEI+lQSoBH9FOIYa5vfUDRrPUn6fmejZv7/Bu/
         1KurxZQeMRpxYAcarCsP/4hJiSs7EoopQjehM9iPIsF/SZpPQyx3lqSqw9jQoJUJO1Ty
         8znKRVEG1y4wZNQg2oz4LMEVdN+Oo/EuQrIYNAcDWjsx+zToU8GifQzqgGUcX/fQifTR
         uVZ3WMyHXaOrsVrae6+m6BVM5JRctRK4h80C9qdC2+TMJg/W6QMQC1QadA6adjqhe4Zm
         81uVFuM37TpdS2UgiXTAnnFwClFv7uSCgJzJf1dyHIA4rN77CBY9H+kdUBvjorG5SR8G
         nL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5gAEQBgCAmrDCYhK9Tm1iY+TdGfsp+0qEGPnEFs/eo=;
        b=upX5si6gLHlJ7Btc6z+aKpFNLpzE7Lsq2Cnp71MNBbZHO+f4LD2+N+PZTmfvpdgUm3
         An+eM8ZQKmSMadGp/F7L4XgGBDr4YK52SAZHVpEYGPhZrbfkYXEmMjaqsTGxPjaW18Vd
         m1w7MwQQceX2nt2ucqyc+yc6NnbKJoA1VjQ1WpBprH6DegQlSa8/eXDF0tFTnOog7rZ4
         iOFGsGz1giFfTQEUnC8h1M/ayLWG665Uefr+OpooMoA+s+JersRk8RdsGMCcR6uNCGmy
         MfZjC9utGfcZlwP++Shec0a1yiVFEnrb249WWY7kNs2ns7JZ2poYN7+usL+yQfpUAXkr
         DcUQ==
X-Gm-Message-State: AO0yUKX76SkcHz+YlGONGBKRchXu8609BWUzAtEEfLS9aeCrUhX5dBNP
        YY9XFxgZHER8Gi3SjsN05wLnhysmniV0Hw==
X-Google-Smtp-Source: AK7set/rmZ+k6nrpbFgIorzkZ4VLxuGK++gD15bI2TQ6sIlmcypiU78CPNr8U37cMrLMw1cwgraq0A==
X-Received: by 2002:a5e:8f4c:0:b0:74f:b453:b334 with SMTP id x12-20020a5e8f4c000000b0074fb453b334mr15840990iop.18.1680132339305;
        Wed, 29 Mar 2023 16:25:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id a25-20020a027359000000b0039c492ae300sm10654825jae.114.2023.03.29.16.25.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:25:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] bap: Mark devices to auto-connect
Date:   Wed, 29 Mar 2023 16:25:36 -0700
Message-Id: <20230329232537.577958-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes devices with BAP support to auto-connect once they start
advertising.
---
 profiles/audio/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cfe6854663fa..464f365a93bc 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1352,6 +1352,7 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.auto_connect	= true,
 };
 
 static unsigned int bap_id = 0;
-- 
2.39.2


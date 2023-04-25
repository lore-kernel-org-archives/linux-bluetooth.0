Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBC3C77B71
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjDYUrj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYUri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B963216188
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2478485fd76so4351740a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455656; x=1685047656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5N5EZhTa5djmxCSRk6kJoormzDIMuBsUEtyg0bX7eo=;
        b=QznwZI/aQbUHeH6zy3xWjd8w1q9U6jHOb11HEEkkNq5+46NdbK9pA3ll3MUFeGOZu5
         a+NK0HHwNxWpo3sV9b8dRypLGTJNdWP7Gf7J8r6LDl1vTK5tRe7Hi0OooEnboaGUnhOw
         lQNpAa2dWC15R4VfnfsYx2akzd+94x3kXZ9NA0DPaClm3z7mLsfR0aZIgL+0vKHYBoC3
         2hVfqqY/jt6VvFc/kkzs1CiASUUefmJtwU6rEsh1pjx4MBCt9jOumuigKmGsNUNlgtBN
         zuOO19PcfNPDiR5E5ColX6GWPU15DUgzKPbYaKp4rTbHleuKYYZGs9VnslcMf2pZLKrn
         19uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455656; x=1685047656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5N5EZhTa5djmxCSRk6kJoormzDIMuBsUEtyg0bX7eo=;
        b=Dy3Bb2t+WW/BdaNu2DTgnatlQSuli85/Ay1StBU1epQI7PcP8ngB0c3DRtEzATbbbX
         Toe/RvQcR0Iu2OfTVlEI+x3J8+xB4tvy+f5S8qdtGW4z/xNTq38Y2hyZYHIJlRYJcCVS
         A2y6oLuBz4pma56I/5QjVcT4G78CFNAdvDeb3tJy7gDp/hq4iKW9gcy5gSfyGqQONhY8
         yz8cGNs+4+lBzOTSZPwlsmBBkye75qDW3svdOxBg0T+aEtPBO9he0reN+9e2po8IC/I+
         U7qGdkzy/HzyRjyD3vY7NLNbUKjmR8sPGpITUuD1g6YKvUB9JX5HsiNkZocY50uc3Wjd
         vUqg==
X-Gm-Message-State: AAQBX9f8pm5CrfN5OiSDKYaTmS/fTwN2G1c1MrNAxJnrzsxeBfvJv4Jp
        7b1WgXMpj5q3M22V8YYmo0YgT8pMxG8=
X-Google-Smtp-Source: AKy350aTh93YE8BYCV4kFaf+M5tZ3g+R3FeBVlguE7oZM3NZKxbxs1XDqk6yS39PFwYbROwx0zqHjA==
X-Received: by 2002:a17:90a:cf8f:b0:23d:e0e8:f453 with SMTP id i15-20020a17090acf8f00b0023de0e8f453mr17569854pju.38.1682455656419;
        Tue, 25 Apr 2023 13:47:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] share/bap: Fix not removing timeout on bap_free
Date:   Tue, 25 Apr 2023 13:47:25 -0700
Message-Id: <20230425204729.3943583-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not removing the process_id timeout when freeing the session
which can cause the following crash:

Invalid read of size 8
  at 0x18EB39: bap_debug (bap.c:553)
  by 0x1913A8: bap_process_queue (bap.c:3542)
  by 0x1A8630: timeout_callback (timeout-glib.c:25)
Address 0x55e0650 is 128 bytes inside a block of size 160 free'd
  at 0x48480E4: free (vg_replace_malloc.c:872)
---
 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f48cbdf5d6f9..52878fcf0368 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2586,6 +2586,8 @@ static void bap_free(void *data)
 {
 	struct bt_bap *bap = data;
 
+	timeout_remove(bap->process_id);
+
 	bt_bap_detach(bap);
 
 	bap_db_free(bap->rdb);
-- 
2.40.0


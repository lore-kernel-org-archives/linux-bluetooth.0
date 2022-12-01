Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24CC47088
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLAQPL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiLAQPJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 11:15:09 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333638C45F
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 08:15:09 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso1957373ioh.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 08:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tafzc7zqNlZvZZxY4VLPgmfl4OQgFKv7rJwz1GbkkCs=;
        b=HBeUf1xbyVqRKP4Aj1PKcdvIsiq5CDNCrCWeE+Ed+1L2NqUP1x9qsT4UDjDDIEZ7Ll
         dWT+x4zWV3258fSfZOtZcmaHhBmEUJnBQMuHvYy1isDr6nz1mfHZAoLsoX9RMerwsotJ
         nwjd9JsOK/k/jFdx8NoHuUNnYPFdDH19KUvBUQI5EMIlfMarmnyHlFdJbK1etA1Cf3ic
         kh0Mq8EOmo2aTMxdee+J+doqqx8NMj3PDSgR73IMygQYcZTXNemWgX48qj7m5w0Fbl5C
         NIWJV3GyjhFRb24qX9S+HhbWPKS61qxjER7a7BN7kdoA9kG5KhfPeP8I6dIotv5Q0esj
         RWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tafzc7zqNlZvZZxY4VLPgmfl4OQgFKv7rJwz1GbkkCs=;
        b=V/GazNM2VyWwVzaRlalzQ4JKKFfWbZPJ3T/W1HX9Ox6OmFrfdybYS5+zI6d7z0vz+W
         87yHOpe41Ia2WUOcWfcUhGmIUqGRcgKwHcB09qePBwugTZEzo/VQFfdeRz6FX7lQqehc
         g4G7TDbiIg+6A0l4PCDo+u3Q+P6poHrTQgCOFMiijrcEv1mrBb7RWNDeRh4WbUwe8L2v
         B725ZHKYwayDjHaYg07ZXe5FchGQrFegnlmLVXEc64UalaD2EBwAOAxN3zsSk0lWr4Ly
         Ihl4fHGj9AgRMPlkzT4DtbLn59lJLuj3d3Vptz80ohAqgauEx6xjyb34PDcBjcRSvHO7
         nGUg==
X-Gm-Message-State: ANoB5pkS/r1mNl9ruoniIxNZnSbwrIfSElKQL+tnd/LgvfpBgHhnJNsw
        Agd9bMebeDS8jviq0Cy836rGQXYjKEGhUAQJisdA4xw8t0Yk53iyJ7Wo9bHYypreVA8ny2H6RXP
        8RYWsMq6bY/o92QfumCoeJOIZlOUwPcWKw2l4ZiaJHsSAEQii/0q/JCqrK9XqqIHGABhyPo4DPa
        OJyHf1QA==
X-Google-Smtp-Source: AA0mqf4DjTbBRgMH4L9SloRxR4HJ3I5G35iF4Zf5ho4WQGklFwhbhhhjJQbo60vndg/YLRsYW6loe7Rcb9ivbcU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:f418:0:b0:6ce:8185:ad0 with SMTP id
 i24-20020a6bf418000000b006ce81850ad0mr23022906iog.213.1669911308624; Thu, 01
 Dec 2022 08:15:08 -0800 (PST)
Date:   Thu,  1 Dec 2022 10:15:02 -0600
In-Reply-To: <20221201160941.1065499-2-allenwebb@google.com>
Mime-Version: 1.0
References: <20221201160941.1065499-2-allenwebb@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201161502.1067068-2-allenwebb@google.com>
Subject: [PATCH BlueZ v2 1/1] bluetooth.ver: Export sanitizer symbols.
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix llvm sanitizer support by not hidding sanitizer related symbols.
---
 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index 214fa8a61..a96fda2a1 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -7,6 +7,14 @@
 		debug;
 		baswap;
 		ba2str;
+		/* Don't break LLVM sanitizers */
+		__asan*;
+		__dfsan*;
+		__lsan*;
+		__msan*;
+		__sanitizer*;
+		__tsan*;
+		__ubsan*;
 	local:
 		*;
 };
-- 
2.38.1.584.g0f3c55d4c2-goog


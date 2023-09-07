Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E94DEC8759
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjIGTlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjIGTln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 15:41:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E7E47
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 12:41:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so10104455ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694115699; x=1694720499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3F5vetMUiLvAQGiAhdAOkew4PcdbGqtiPjB8vMxeeQ=;
        b=Aay+HgL9lk+1TlJhhq1X3QVnb0RmHZVrTBtnSq/uXuo5DktEVRhsaWdhJ6toNzlUEt
         xI03iurrxdS6DrH6MteshatS5kGkbISxgA+bdfIxas9RvPUdV371U/YB9Buku4irTNtH
         t9A6PJS7ECGTJ9wdKyMP3qAFdTj5fPVvaoqCiWMgaXpqr4ykXTXtU1Rj4RCYQ0PeJjaa
         LEmcuvRY6jLdX5kkk3HrCeYmMe15dbi1dtT4s3mej9ror7XCcmOPjzCi01l4u+xkFiFL
         UfV+2G/+80h44N3Ls+wbzSgg3BnnatPWPIdhDZrg33ZKGZA2L8RpCgl3B0QCqWTl1BlL
         cFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694115699; x=1694720499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3F5vetMUiLvAQGiAhdAOkew4PcdbGqtiPjB8vMxeeQ=;
        b=ALAnkVekVdhoDr5FphYOGMKklDhazH4a4rP6zn2NakLOQj9mnSn3sgEMYwvtT/D7BM
         AzeODbKJk+CJ830KxJvLhDQErs0UdmHla1i5VFyWQetUI2qHNIyODqZyh6xcnqNkQSxn
         6JqQlhv+cEkfo1hNZAHli197u2zpE6mJO7q72NwBW+VQ4xP1z7b/igA+f+fDvGeNDIIl
         eGW6EAYffeuGrrmjoE4EqVo9ikUQ6jHVZUdC5Wtr2zvX6yknIreGb4/uJ1wTnjOfuzLL
         gkezttFngHg2Fbp0/7nd5/arhrRrNTfwRRPKuiohqftdC0IeSbjNCHpL0i1ZmNpqalUZ
         8kkQ==
X-Gm-Message-State: AOJu0YzhmOogOT/a8tP8jAxvmJo8SxF2Y9OC0hsEesa26+mgqHX0GP+v
        U4HOzSGrvLtlbM0qiY0ZF1ZWAUzHrbw=
X-Google-Smtp-Source: AGHT+IG2SSxVX99qLIk1494/rhqwdpz0X/RGSuGdRSeXSKN0gLZ3smQXFm4lnrPZ/pISvJoXLl7zIw==
X-Received: by 2002:a17:902:b943:b0:1c1:f3f8:3949 with SMTP id h3-20020a170902b94300b001c1f3f83949mr606578pls.1.1694115698939;
        Thu, 07 Sep 2023 12:41:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001bbfa86ca3bsm129352pll.78.2023.09.07.12.41.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 12:41:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] main.conf: Fix documention of CSIS.Encrypt
Date:   Thu,  7 Sep 2023 12:41:34 -0700
Message-ID: <20230907194134.2242634-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907194134.2242634-1-luiz.dentz@gmail.com>
References: <20230907194134.2242634-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CSIS.Encrypt is a boolean so it shall only be set with true/false not
yes/no.
---
 src/main.conf | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index d108934a8ae9..085c81a462dd 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -270,10 +270,10 @@
 
 # SIRK Encryption
 # Possible values:
-# yes: Encrypt SIRK when read
-# no: Do not encrypt SIRK when read. (plaintext)
-# Defaults to yes
-#Encryption = yes
+# true: Encrypt SIRK when read
+# false: Do not encrypt SIRK when read. (plaintext)
+# Defaults to true
+#Encryption = true
 
 # Total no of sets belongs to this Profile
 # Defaults to 0
-- 
2.41.0


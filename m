Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18E207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJya71+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgEUR4Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEUR4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 13:56:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918CEC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r10so3518655pgv.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6W8qc7zgMj7u+zWVK53n2ZqkCOak7mVuv8kyGS4iGmk=;
        b=IJya71+UeSfV9HFroYHqENIObrqpUwb+7P49kbkqDXvxumPykPBuHmg1U8k0KrffKq
         xMLR1KMjni977YlgMm4hzXcryUSl7d/NyV1Aa9ntmiqzApWGIhfMVLXxxjkrYwzST6GE
         Trvm0q/gKQkJAyQL6QtZVAP4BolBRWWltf8Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6W8qc7zgMj7u+zWVK53n2ZqkCOak7mVuv8kyGS4iGmk=;
        b=hEqCSgDXYqiqOLeO42TRvzrFFAsmPl10MuVEck4xRfwiA4BpT8Kj007+A2wBox8UQB
         zfOM0VsGXbcV0C505Lyiy8qvaMVJJgdhu27fWG+0QknrtUAi6XKghF1bma0NLOLO/s7y
         BZ/T6rDoZ6ww9yMYpvc+oMymEm1z6gnVr/gjNGo+Wf9AK65RPe6T9Uq5VoqMesQiZhbP
         0T/AdMJA0VA1ApLvUErOP+X006ewqYLdnoNFFWOXvscf9wjHM0oPBNbqwlzolbiR2HHz
         5eRMGpNKA0Ypg7FVABV860SlcRu1Xd2KIBHznjZn8UqX6b5S0EXEV0gG4o9tl/jKK5KC
         sC9w==
X-Gm-Message-State: AOAM532rfh9CoEHjWsTTjfLbgjyxLqHUT5tqWHsPtmw1Sy4oBi8ZoTQ4
        qu+1N3Ye4QsOKlS8yORvRhV3RGsJqKQ=
X-Google-Smtp-Source: ABdhPJzpoDGwHPVsD1UQyS9KKX0nQUjnc5uP8iPmwmofcmk2bVADQcAp8tYO+ge6FuIOaepmu9MXGw==
X-Received: by 2002:a63:e143:: with SMTP id h3mr10290692pgk.85.1590083775889;
        Thu, 21 May 2020 10:56:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id a16sm4881910pjs.23.2020.05.21.10.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:56:15 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2 3/3] client: Print device property "Types"
Date:   Thu, 21 May 2020 10:55:43 -0700
Message-Id: <20200521175543.7923-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521175543.7923-1-sonnysasaka@chromium.org>
References: <20200521175543.7923-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..dd8c28cb3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1628,6 +1628,7 @@ static void cmd_info(int argc, char *argv[])
 		bt_shell_printf("Device %s\n", address);
 	}
 
+	print_property(proxy, "Types");
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
 	print_property(proxy, "Class");
-- 
2.17.1


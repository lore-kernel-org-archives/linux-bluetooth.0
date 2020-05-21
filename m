Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C1620759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZ+QGpyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgEUSB0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEUSBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:01:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ci23so3448858pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6W8qc7zgMj7u+zWVK53n2ZqkCOak7mVuv8kyGS4iGmk=;
        b=BZ+QGpyceqYcev746zJuRRJfF+PxMlKijUNgZUnXKwTpkwFLz3mx0+IkyqCC7U7xmd
         lS7K4cxsgm6oaHd5Ybh4wqMVQlHh8BRexl5rAw2NNr77l8/Dnn3J2LqMY3ZXO4P13atS
         Vw4GLl/G44WCTJ4Bv+AOyY14ySQhtVgVpBg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6W8qc7zgMj7u+zWVK53n2ZqkCOak7mVuv8kyGS4iGmk=;
        b=AMLnVfDQPmK8WzlV/igJzCQuz6sX4VSneLY00Pszz3jcK9IFBpnnpivIaPju5Ugw+R
         KEIkwzvnI1qwgHKsbDgkOcNEqdnUqeOyLph/Fno+F7p3T3tFPAoatVraFy+Hy3NfAkl7
         VF3DKn1qgW+6rRX1DOmqJV/5hyOgR2xp/ChRXTqg3g3/fdy9cr1sLKtnRNYnyqX52osh
         py7w7IsMCGagLUkUxE+wbXSF+80Ukh4cghnAXfLR+jqv6SDmBoaKOxn7H5q1r/sKTC38
         OV9wGIM6pDhQZ4i8F10n0cFOIIysj+9vV4dCGh1kB2v2ei2RnXVYbV+6Oe80zDEBNZWD
         0csw==
X-Gm-Message-State: AOAM532vjBqZyrKa7wm91xb3o8WRWvteMaRP3Dxet5wD2GO5Dp9ipGMI
        CmA+P4haiPutIB+6qDLl5JG0v0VYOyQ=
X-Google-Smtp-Source: ABdhPJweLfSBekRY5zT+wMecHSe4O7AnxQo9qQXx79uAgKDVDhc6AorRemFElWoU0gMwN0uPE97qTw==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr10558426plf.115.1590084083820;
        Thu, 21 May 2020 11:01:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id h4sm4845975pfo.3.2020.05.21.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:01:23 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v3 3/3] client: Print device property "Types"
Date:   Thu, 21 May 2020 11:01:01 -0700
Message-Id: <20200521180101.8223-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521180101.8223-1-sonnysasaka@chromium.org>
References: <20200521180101.8223-1-sonnysasaka@chromium.org>
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


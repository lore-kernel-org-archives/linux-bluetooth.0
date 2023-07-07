Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E2EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGWoo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGGWon (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 18:44:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEAFAF
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 15:44:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7659db6339eso121742885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688769881; x=1691361881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIvf/Hcd2SdfnTN2hhITh3CzA7mpuuX9g5aHh7kP08g=;
        b=okzUbMwxq3KpeBm9dqgFPB8ksGMLzJHrPNzV8jNI39Oc5NnQ3y0cipFD6yJZacVEY6
         plP+6uc3DR4WCzxc/q9mq9MUD0IQ9YbjOBis/W8iPTPP7ZDSm8rlyi/8oFbmFLUUf6WJ
         0g6VafAoKapxJEu1J/teoPWzwLBe7K2qJMSJg94SklxAkC0QsxyRn2ZR/mCqPGNEGgLi
         Bn+9Pxti1IUtkS7LnHFnVh/BRKtaluy8YEfqN5JZqXcP/EBj9VYxxtzoCkG2xUmlWme2
         L7CxkjFGhzlyxU8ds+uQE1lLjYnt63EVZJf+3tv9icpSHWgg8ygtoGHmnzx8G9wxrG+w
         kfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769881; x=1691361881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIvf/Hcd2SdfnTN2hhITh3CzA7mpuuX9g5aHh7kP08g=;
        b=T7wyiEk4f+i7WzNIiG8INfdfyJN794RdVWZ3LQA5Ynvd29OllePI+cei8yf6svrDUk
         Bx5AkFIvx+wf/Fc28y9S+C1qEfUk9DwXCdV5Ks+U0e4nrq/xy6WmR7krnMvhIDhaGjQ3
         R0YY9dN8wRJUE+LaVetj8H6bBDqmjdFYURznDeou/BL+j8VXPO2oTQLc8QpYV+uIoRC+
         X7sDw3Z338dY0eabDA8tb3UJc523ZEjUA4/bqe+LmSi70BpjEZHDkkUaM8lKCgNjfmPi
         16Td0wpOkIElYOeAh+dCPCJMP975eIYlPwyUpAwjutg4IR1X7vAVO5otzdGMYpS5qO4V
         fZJA==
X-Gm-Message-State: ABy/qLbjLleq5QyMPYkg12rciYlUVouljQIfQh4N4fLZcNoYwmb2cdNz
        tg3pkAccPGxaj+5Mv57kzjygYVO2Fy0=
X-Google-Smtp-Source: APBJJlHqyKsyhKY78sxG7gbfV295RlgbTEHEy3gpC3sKt/Y5IuTRvc6Cgwhq3p3cXePcFeUcPZOmVA==
X-Received: by 2002:a05:620a:45ac:b0:75d:49e6:26c0 with SMTP id bp44-20020a05620a45ac00b0075d49e626c0mr7106076qkb.5.1688769881166;
        Fri, 07 Jul 2023 15:44:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id z28-20020a05620a101c00b0076730d0b0b9sm2274482qkj.14.2023.07.07.15.44.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:44:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] client/advetising: Allow use of EA data length
Date:   Fri,  7 Jul 2023 15:44:34 -0700
Message-Id: <20230707224434.677627-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707224434.677627-1-luiz.dentz@gmail.com>
References: <20230707224434.677627-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was supporting a maximum of 25 bytes (31 - 6) to be entered as
advertising data, but in case of EA is used that allows up to 245 bytes
(251 - 6) to be entered.
---
 client/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index 24852d93d1ec..a7474d6a2984 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -28,7 +28,7 @@
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 
 struct ad_data {
-	uint8_t data[25];
+	uint8_t data[245];
 	uint8_t len;
 };
 
-- 
2.40.1


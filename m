Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260FC77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjD0XOF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjD0XOE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 19:14:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CF2D65
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a920d484bdso71213675ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637242; x=1685229242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=UYihX9RyEjy0a2X9L632qPfzhAXmqMj3aQUUQpNHEqRal5X20Y1MibQn7od/Re/CoW
         f/sxB+cJbiwuZx+iiwWu8xFkWX3IeUO+N7QtxtehoAVZYQ41dVeOpNHoY18SVIKON2jp
         GDhPmi1txNcLNTB53NMEwR06a5fLaLxQBw7DUhqSnyPx5ysZF5Vw328iQr1oIVqCeq0M
         dPEQfssmT7ZhXK4T7TmioTilyfGMBMA/XCd6xYv6uiZ6R6EXxVc1UxFjiOnTIoKkBdHW
         MlG/n2g+WvFfr8WnLnKGN29z9rGOe+3yFpmdWTbZ1mOvGltCAk5vf3WJ73oRjr89OdWs
         lfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637242; x=1685229242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=EvgPBQ0u3qAmbtuQaVIUOSGJGRt/ltZ8uZ+UBkFrdWgo+36Ae6dpaFEkLqNye/KF1R
         Qy99/Mgdk0YQp+5F5yZZrnoLLgane/rX9EidGiPxmG2SE5Z1nKz5C/56Z8ok4rOjmhDS
         X20wbk/JWIuvkMAPFUmQFEPAZkPQj0xoxWpOrWzGj+xUNqiizH6fz/TTgg2oQRB88EGd
         vDEF8bDJ5Njj7IyuwgzOfrClky59NHnyb2Fw+X63Lw5xHfJXa8+7f/iz9YuCtQO8bXuA
         72I4OSf8XpzTUJBkji/uKA0CjTVEwrA3sEcVPyzQ0xTGoqi+41oDv+tXjAxAT/SS7QBw
         HW6w==
X-Gm-Message-State: AC+VfDyNjvRxdqSwnskBIvTqGQIfyesIWCnGnXqml8ko2vwhZ8q0SonH
        wUSiZlpB9KPFl2wfPfAeINSJmuqOj6E=
X-Google-Smtp-Source: ACHHUZ7vMzoGUpNdO+MV6ccX2mX/usJJ1XWfEn7ta1d9He0B6QLkoM46iBJrSAQEqx7+FtKBp2o6zw==
X-Received: by 2002:a17:902:c40e:b0:1a9:7e24:eb23 with SMTP id k14-20020a170902c40e00b001a97e24eb23mr4183632plk.52.1682637241843;
        Thu, 27 Apr 2023 16:14:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm12112369plr.236.2023.04.27.16.14.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:14:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 5/9] shared/bap: Fix typo
Date:   Thu, 27 Apr 2023 16:13:48 -0700
Message-Id: <20230427231352.576337-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix typo s/BT_BAP_CONFIG_LATENCY_BALACED/BT_BAP_CONFIG_LATENCY_BALANCED
---
 src/shared/bap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.h b/src/shared/bap.h
index 0d419aa74982..e9f769d0ef3a 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -26,7 +26,7 @@
 #define BT_BAP_STREAM_STATE_RELEASING	0x06
 
 #define BT_BAP_CONFIG_LATENCY_LOW	0x01
-#define BT_BAP_CONFIG_LATENCY_BALACED	0x02
+#define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
 #define BT_BAP_CONFIG_LATENCY_HIGH	0x03
 
 #define BT_BAP_CONFIG_PHY_1M		0x01
-- 
2.40.0


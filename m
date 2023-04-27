Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC443C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbjD0TdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbjD0TdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:33:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351D10CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760f29073b4so244028039f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623976; x=1685215976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=C3n1p5TaZI8ik+k/42XnmDd3rLAUVAhBf2A1p2ceOk8fNIjoCTsp5foVcUNO8epb2m
         QgaMsG7QbO9CswYAOhrJsFJKeQvtSpOKiGOi8hwL988mL4MTtqxdPQRD6vrD2/BnLhdS
         gVyD7Rl+jxJUVZxhDNyZ41t/H/54ZgRVRQUU6CpJzFt+wpIAC0l1gtcwGwqMpWJJ7hj+
         okSTUPpOacP50ipbDypsSAp8s8DOjfaMA0vgsfpVjzvPqBJjXtQ/stqgxF+gB8HGYKKQ
         JyRUCf3/TbqXINepikIDBdrynawzkWaODARvsjiGZLz9/joqJdB07hkc8RZT4IjlI6SS
         a6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623976; x=1685215976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=GczdDUV0mhM+ePFt8aaMoGCFA1GCoO48YIqPDCC027FCMXh2jLmf3CjuKCmJgBUQen
         VBqUuIH3XC70NZbtysm2gJcVdjg0arla5aDL9uhxWoerwx5q7wpl4HLNsG4BNmyjN0+Y
         jfEoSp5kaH3Ye9pFwBICHv2KyiI9E/JvnkZqFNt18kp7Us2lK6y4P/IUrwMcx1YMl+VK
         1kZbYXo5XCm9HMD02UoAig8uZqoIe7F+AfsmdX+iIDcFCeo/DwAMsLgCoifydF8Bo52Z
         HFZn5XOJyrJxC5cpNpoKAJ+ToBWn5zx5cw7K2YqLdiynPiJBRMJUkNiz7MjiAxTWwExh
         48bw==
X-Gm-Message-State: AC+VfDzJyxnYI1p7MmyWjrInca2dOM18HyxH32a1h26BtW7zWOl7Gl2O
        ME10ik72tywXbCa1Mnwn95cH/z5CiUw=
X-Google-Smtp-Source: ACHHUZ4HjkJBLO2Yl+GF6g7hYf7BW0qnfWJQlHAe/gi7M5AjxtzXRg26DasADAF490oJvPyX66+fpA==
X-Received: by 2002:a5d:924e:0:b0:763:538e:2316 with SMTP id e14-20020a5d924e000000b00763538e2316mr2169576iol.9.1682623976564;
        Thu, 27 Apr 2023 12:32:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.32.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:32:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 5/9] shared/bap: Fix typo
Date:   Thu, 27 Apr 2023 12:32:41 -0700
Message-Id: <20230427193245.323502-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
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


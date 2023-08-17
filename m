Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D82C678DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 22:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355802AbjHQWlh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355789AbjHQWlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 18:41:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA4B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:41:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso133465ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312066; x=1692916866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8Fm0hxWBZ6wilqZy1iDERfetf4M3xy+L2/2VQ17Y8=;
        b=UBbVSOwuSiUFJJg4aZ9yxWgm4d6U/eIUHlf+LyVLcEHT3aIns0prxIU/snawg1MUMp
         3Xe3iHX70ll+99BfPT3ca/SK5QA2VrT/vviJ5yOehWlUaaV3acZ5Ig9yKbR9T2t5tIF1
         Mh4JabwpPa4BjICmLuPtefV2VyKEDCXmBUjYSxCxWp7hPzIOp8NF0N7Hu7SE/v9whNHl
         kyIm6ONMBWegOi/eeYXdLlvsJk3CaPTDOEtBu0AQOPxmTLcBb58+jnfV+FXr1kzVlcV8
         68X1kTxxKuQD8jtYc1kwDz795r4xyxA8Utpj3yBtZhVcA2AEuR124tGLn4Tg+Dh2NxW/
         34zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312066; x=1692916866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8Fm0hxWBZ6wilqZy1iDERfetf4M3xy+L2/2VQ17Y8=;
        b=gvPwuGxA0U9Tp2cGnqnaHQgeB7z2+mJpYzF13qxAcqRdkk8qy7+4MTIrIGRq9QG5Vg
         GWWpSBLQj+RV/m3pcMzZpLfPzAzx8+y08tSb8Xbm+xI+HF/GrmEe1/w5uiTpPa39xKtF
         tR3FfRZKtTkKHsRWIZlvCmoQEldwqk+6+C8xsYLRZYcFsROku+6APx/DbT2Y/IBJ03qO
         iFJE6S3SK97sBEsvC3848kJjSxuoD0r7dxcwWsm+YqnKyhaN9HkHoyPc2UlnSgIviCe5
         FYd3WwuGf/r8YnWq2W/wvCkpBPCh2bF7lfrK5BLRaZTBaYwzxMe+zb1Zn70YsZn4v09j
         KhIA==
X-Gm-Message-State: AOJu0YwL7eSCyJLAKJ/4EYwxdQQfuucdOXG82KPXZ5P79MTcSFrFGDdA
        B/if1LD2IhvIYa0ZKG2at2nUDl9qpR4=
X-Google-Smtp-Source: AGHT+IFcg0mubcXW9TO1zKITwxkL/MapkQ4Qquw27u7FVmy1v673iyzzawNuh9O2O6qaqkp8O8wAqw==
X-Received: by 2002:a17:903:1245:b0:1b8:66f6:87a3 with SMTP id u5-20020a170903124500b001b866f687a3mr923309plh.52.1692312065821;
        Thu, 17 Aug 2023 15:41:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001b89b7e208fsm281877plb.88.2023.08.17.15.41.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:41:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] device: Don't attempt to set auto_connect for devices using RPAs
Date:   Thu, 17 Aug 2023 15:41:02 -0700
Message-ID: <20230817224103.3042055-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device using private address cannot be programmed into the auto_connect
list without them being paired and its IRK being distributed otherwise
there is no way to resolve it address and the command will fail.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index e0ff0b1c1543..f6b0167bf55b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2006,7 +2006,7 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
 
-	if (!device || !device->le)
+	if (!device || !device->le || device_address_is_private(device))
 		return;
 
 	ba2str(&device->bdaddr, addr);
-- 
2.41.0


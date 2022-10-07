Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04116C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJGWh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJGWh4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 18:37:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0D9F744
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 15:37:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso7778056pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWZTAG1Eih+DouCQoHVwsrrhAQjYzIpkDznjhxpWO28=;
        b=J3DhTy+ZS7HhwoiBXHDJDSQoZj+PhAEiN7H6R+WRQsxaKQtKMkD0fFXonr1+iwLL9k
         Y0efiqAs53zhQ4RY3/xXeoXP5NjENvCg5F/+EKPG+KUqufdclziCRn7bfTlrpTeEzNUA
         eE4a4UcDwtTtB4Tc63U2DElSCmKwt18PZUdC8wnHzWZJnL4Ns448vRfsvVDwFPKQhMI0
         GVSzySt292VlyKkiFcQRHJcYWKWgGfHp9mQHqIN23CTSLoQpwo1wsc8LeIkKdrboGPpy
         VP29G8BuhGG20doFcv/PPxd0q9qAy+Q81Xn9rWXQkq21Lab8ijR0EqI7Ynxa02ZrjtwM
         pwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWZTAG1Eih+DouCQoHVwsrrhAQjYzIpkDznjhxpWO28=;
        b=JUaFLegg6FuJh2EjHFZv+un/e3laVsrHqkim43FBXrxTZ543Z2EVHCvvJVge9+XqCL
         DHT2MTSK29eY+UlCHLeE6urm5CSaV/Gb7BjFfQX6SAP+4QhC4ZEZs0IFRky8ViL9k+9y
         ufzES02S0DjV5A5oII5T+J86/xwPAuCzspPnbZwTICvJtbfobZsrXsdncsgyyyr0UOT3
         Kbq+2B7U8esExRrWpmeG7nNFCdqbwSrti3pXh+Tn0yOMChCkyAuFTF2NuV2bHPuslTfZ
         4Wt6JJAYU57eEUWsYVWoK9XZlFTnZfvVNtb43CwR71j/RguoAqgMXSoCX/FWW+S5znmQ
         jRGQ==
X-Gm-Message-State: ACrzQf27rfZdj6qVhqkTpU4Z7rycZvGPkc4ks/PwuzXmB+FOMKnzXEsA
        YzOvELTk1I18zG0Eb4waBl+um/uMPr0=
X-Google-Smtp-Source: AMsMyM5Fcn5VtRsAcxEa8x0w+nBLf+0VncHavtDPWX7sUyVlh+9A9kagMLxtl6vcEsGSp88rKxb5KA==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr18419098pjb.200.1665182274056;
        Fri, 07 Oct 2022 15:37:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902d54600b00178af82a08dsm1991647plf.91.2022.10.07.15.37.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:37:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add support for setting bdaddr
Date:   Fri,  7 Oct 2022 15:37:51 -0700
Message-Id: <20221007223751.1832559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btdev_set_bdaddr so it is possible to set an arbritrary
address.
---
 emulator/btdev.c | 10 ++++++++++
 emulator/btdev.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3fdfb64a9eba..549f93645684 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6960,6 +6960,16 @@ const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
 	return btdev->bdaddr;
 }
 
+bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr)
+{
+	if (!btdev || !bdaddr)
+		return false;
+
+	memcpy(btdev->bdaddr, bdaddr, sizeof(btdev->bdaddr));
+
+	return true;
+}
+
 uint8_t *btdev_get_features(struct btdev *btdev)
 {
 	return btdev->features;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 228bf205cf4b..cad5f699f801 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -72,6 +72,8 @@ bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
 			void *user_data, btdev_destroy_func_t destroy);
 
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
+bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr);
+
 uint8_t *btdev_get_features(struct btdev *btdev);
 
 uint8_t btdev_get_scan_enable(struct btdev *btdev);
-- 
2.37.3


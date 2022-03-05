Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19BFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiCEBXf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCEBXa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:30 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F83151D
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w37so8874045pga.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zpoj1dZTGEsaE4MFshJmiX0Xk6PBd6Tolyq7wU9OsX4=;
        b=Z8d8tqNNBYi5OJ17HudHPTqWYYqZTf+7a8BcC9zHXcpEviEO0iMfp7FKoAwRso8gri
         wm1OKGveaBimS9mj5K1ew3z5nab2SLTrwaHAXyrSnpfKWBVExgFB2JVK9qOWL4Ir18Ju
         lVJjI9FMmhfL8kjOTlYF7aWl9yMkR4MAQhSeVkze8B67zjyPzyWqPThvbmS2aBnaJSpv
         DZYK3SNgHZMiDcCFiIipX9Nxjcj069LLbWetD3RrDSHhk6JVGw1i73QNzZexNLA/eSPH
         ywWYZTBJeMCUyGXzO4ozubMHMLUFApRBqUpHnOEW708H//nyvPTxdwQwN+fr5p+a+JJ4
         asdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zpoj1dZTGEsaE4MFshJmiX0Xk6PBd6Tolyq7wU9OsX4=;
        b=3ZAidV42mKJAGxvNdiF7jg11m5kD4fs7L04vhOCMcKO9O6OnsHkXzNI03C33pYcX+L
         Mo1uYJI4ggdhFX7Ti5iX5zPxBoTY08zjb3MvfBGHoKg7XnQ9Ez4R+sOf2zFZxXUGscj8
         VzEx8uiwoOyOaTmHG4A8llZpmo4/+tMds2B87AAwiK/WjSo7CBLbHtERaBeMhUH8RWSv
         eZ81uAelNfYg7IW3sF9Lgmw0ddRj8ChwfcCRJ3hMMU36n3oRG9hkooOP9WMvQv5d8huz
         PLm8JmNadfpHYQttGqeZTq4JuSgNlbI06OAOUuGT3QQzB9VFgdH658YZ9JdmqcOGMKQv
         l0kw==
X-Gm-Message-State: AOAM531uO+jxTblRWxZYs+4V7frV8gCkm1ir0q9m6PtYor5dMG7IdcRv
        bSpGRBJyy+0RffHFEkwRIjECIffwnfk=
X-Google-Smtp-Source: ABdhPJwKIWZIen83G8x29e4viUhpwsLfQaURtYgt46Fmw+2yvJ3indxVgPk/19szqx5jO826Irxe2w==
X-Received: by 2002:a63:8ac8:0:b0:37c:ed36:8e45 with SMTP id y191-20020a638ac8000000b0037ced368e45mr941125pgd.48.1646443360793;
        Fri, 04 Mar 2022 17:22:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 12/12] bthost: Add support for Create BIG
Date:   Fri,  4 Mar 2022 17:22:29 -0800
Message-Id: <20220305012229.853784-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_create_big
---
 emulator/bthost.c | 13 +++++++++++++
 emulator/bthost.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index a45a67d14..f629f2e6e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3096,6 +3096,19 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
 }
 
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis)
+{
+	struct bt_hci_cmd_le_create_big cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	cp.adv_handle = 0x01;
+	cp.num_bis = num_bis;
+	cp.bis.sdu = 40;
+	cp.bis.phy = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index fb7b1431e..ae5678009 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -97,6 +97,7 @@ void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
-- 
2.35.1


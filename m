Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D543C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiCAGPu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCAGPs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 01:15:48 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC166205
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 22:15:08 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id c14so11119916qvk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 22:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhRFqQxhow6ysy3ca88o/zYVFcSiVE/UZrBNrZ70fvY=;
        b=C7CZ7C6RsdwpkJrxPSG1KItERoF70HFsF4tQMa6J3mTvpCUBi1/Pc/cyEVCJb3fTPm
         aYjBv89gsAwPH8d+k0EH80NQEhzGfWd1srpVSRZhY9hbklHpdqmOo0N1LtOIY3/687DO
         q80sYWSB8/Rw37mcFjArVX3Pdm8xoIzpyCFKp6Ip102nYw8hoOxt9KsccfiCX4cME+XE
         0yQgMBNgy/v6M46HpwLVOKryX7BybHNHnCaSL0x7l4U29U5EX9LNVzht9VXHvgdOH7YW
         VfaUcwJH+Ywz9OzSDzOmgAdGZoENVfoZbiFEo53MnKZmaN4Ligu7u5VuHBgxcNY8nlw7
         EbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhRFqQxhow6ysy3ca88o/zYVFcSiVE/UZrBNrZ70fvY=;
        b=EtEM4LpMYLaA7UmxmRc9XwrdIoeuWtP79FICnrf4aIpUku4dReeBER582vAsRlPPQz
         BWmRmfSAC8slRzPttfJnF7Ys8GiPnRCgHR7cR/R7eguEuZDiY7QcercWqzlD0mE4GWO7
         Sx0MKqDMer8WKy6E+vzaXZomsROK4FWa2aUsvpEMziHkwpjptfaeHNqiYGAQQ350QGhV
         c8FYZXkfpROxLyn8MyDTwIlqBTLXws6z7+Ghhx+lNvxs36SOUD8tW0cszyezajsQK1EP
         XWMBJKhYVaHJfDM7SYIsWVJvnH5XRx7U5RwvOS9Lxs9adtj14cS3oJvZyxQCcyL6z7NC
         8nFw==
X-Gm-Message-State: AOAM5303zPsnJZvtpRgjCTpY1iCJ0uycV49lEuqOLg20yqY9DdY/ushD
        L+9rE5+HCJIcE0F92Y71cL0DN4pQ4HteuLgI
X-Google-Smtp-Source: ABdhPJwIh66psYc67ijhyOm+ROatJU7R9sE+nuoFmeqCLynFaD6lpBJzp0+yZjHmYsBj0+4DTWIFKQ==
X-Received: by 2002:a05:6214:4104:b0:431:d89a:66bd with SMTP id kc4-20020a056214410400b00431d89a66bdmr16238751qvb.42.1646115307453;
        Mon, 28 Feb 2022 22:15:07 -0800 (PST)
Received: from fv-az193-672.ibjetn2pge3ujnh3vtdq41oyjh.bx.internal.cloudapp.net ([52.188.209.207])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a12f300b0050871994f63sm5950916qkl.120.2022.02.28.22.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:15:07 -0800 (PST)
From:   ihsinme <ihsinme@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ihsinme <ihsinme@gmail.com>
Subject: [PATCH BlueZ 1/1] fix writing out of bounds array
Date:   Tue,  1 Mar 2022 06:14:45 +0000
Message-Id: <20220301061445.7626-2-ihsinme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301061445.7626-1-ihsinme@gmail.com>
References: <20220301061445.7626-1-ihsinme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 52e2399dd..3992f9a0c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3831,7 +3831,7 @@ static int load_chrc(char *handle, char *value,
 	uint16_t properties, value_handle, handle_int;
 	char uuid_str[MAX_LEN_UUID_STR];
 	struct gatt_db_attribute *att;
-	char val_str[32];
+	char val_str[33];
 	uint8_t val[16];
 	size_t val_len;
 	bt_uuid_t uuid;
-- 
2.35.1


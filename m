Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1032CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 21:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354202AbiCXVie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiCXVid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 17:38:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9076B6E52
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 14:37:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so5836176pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+DZPJ4UeslbfD6dBYHluzn4a6G41JzfoQ0WMq18L8U=;
        b=Xjv7nlDlvksa1107J/upF26/2fzC72qkmnFKWV5oibMfnw8aMf+K6bcDbp3Glz5/xW
         jAvSiaQGR+MYrjBxCIwMZZZXGhKF7IJd6TaN0o+TyoLe0VclnmDpwf3NI51HnFiKHXmS
         SODxAbKaWhREUVlN8hNdiR7flI5SVqoWSWtjn954fPVpofLZF6+7Bq3Hl2SrtYXEU9OO
         eIaK1ibv/ng+oc0Mvhrgclb064M/w+r2/zkH/eeG1qabhkqUSW1O8eo7rbW+PpN8Phpe
         2sSIXz4HMlyD69e7bNklxDHJK3QojPvEb5Miy5UZ4hlUIQNyLsEmuH8GsG+Su2lKbcjR
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+DZPJ4UeslbfD6dBYHluzn4a6G41JzfoQ0WMq18L8U=;
        b=geENczKnwtQtpOeOB9j+HzAOAxKukiVDf9K0NL3ziFZdPtgbehpfpYeObBnS/I3H0W
         VDw3pXd8f2OWhcXwD+vR8UERZu0RlWise8+5u3HNwqRoiPlc4iQzlAd/PLZ8a+RG34xE
         rEgLjOTq0aFKWR4ArTyB/F7AE2gpJIyBV8YIu1WbPpp1o0O4Uhq5Z3dZ2YwCMU2xqecd
         A/Fz0ZReT9UQ3hRc2b4QA8EIxtibs1G2kvn4657hy8szl2bB7VjTJ30PsTBzo9vX0+G6
         n9UjmLWqAp0XiG/KHj3cSeWacw6EHN+PCMoUi0dvnYotGIKT2nN69W1+SY/vWEpDL5BL
         VSyQ==
X-Gm-Message-State: AOAM530ohuqHqN4Gr9AroMb8wdaCyKqAqZ2VGdzVkwXopTyePXkgh1BL
        fE2Yg+DcNZ02Mj/5Lp12fFYw3g45S4I=
X-Google-Smtp-Source: ABdhPJx1X2XV6tH3GZlaiXjH8WFFAsLf/GxwK0mBlhEPYHjpx+vlPnx75v3VI4Wt46xKuC5Fx4tc6w==
X-Received: by 2002:a17:90a:7147:b0:1bd:24ac:13bd with SMTP id g7-20020a17090a714700b001bd24ac13bdmr20852742pjs.70.1648157820039;
        Thu, 24 Mar 2022 14:37:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b004fae15ab86dsm4696489pfc.52.2022.03.24.14.36.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:36:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] adapter: Fix adding SDP records when operating on LE only mode
Date:   Thu, 24 Mar 2022 14:36:57 -0700
Message-Id: <20220324213658.59479-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If mode is set to BT_MODE_LE SDP protocol won't be operational so it is
useless to attempt to add records.
---
 src/adapter.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1fcf75ec4..e8b84ccda 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1227,6 +1227,13 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 {
 	int ret;
 
+	/*
+	 * If the controller does not support BR/EDR operation,
+	 * there is no point in trying to add SDP records.
+	 */
+	if (btd_opts.mode == BT_MODE_LE)
+		return -ENOTSUP;
+
 	DBG("%s", adapter->path);
 
 	ret = add_record_to_server(&adapter->bdaddr, rec);
@@ -1240,10 +1247,17 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 
 void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle)
 {
-	sdp_record_t *rec = sdp_record_find(handle);
+	sdp_record_t *rec;
+	/*
+	 * If the controller does not support BR/EDR operation,
+	 * there is no point in trying to remote SDP records.
+	 */
+	if (btd_opts.mode == BT_MODE_LE)
+		return;
 
 	DBG("%s", adapter->path);
 
+	rec = sdp_record_find(handle);
 	if (!rec)
 		return;
 
-- 
2.35.1


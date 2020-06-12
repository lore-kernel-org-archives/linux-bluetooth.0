Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67859206D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 19:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMDFxJ+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFLTeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLTeF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 15:34:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BFC03E96F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 12:34:03 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u17so5956815vsu.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVVWc6HyREAoGnNyqlZ+8iYxN4HVegfcVcqO1g9C5gQ=;
        b=SMDFxJ+DubD+yQp0ET0n8bQqWTHBMXU1pk6HdT4dW5x2M1tyA/HSjBc0Fjtarau3YK
         FzHr/PsyDGlAysrOXt7GCEKIV2qgXvRSPUCxf4OgvrLmD+d+sUo5SWQpQLBV4d7YJ3SK
         0RgCelq7AMKkSgRyzyicKh+iqAGw5tRErrmBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVVWc6HyREAoGnNyqlZ+8iYxN4HVegfcVcqO1g9C5gQ=;
        b=seWEgaW/Kh/NstZkyei79Zh7KMreYiL+0mqfOKoKuXkxCBoMPibhlSP2O9js+NhHg6
         ZFATzADcLu0o23SXyMi3M7ZEAd1p1L7R0WcfiOM7ux4QGUrTi4KohQCBF7SxMbfMJ/NH
         MM9WL45yAaSfjosN/ujVlsejrHK61sJ0c0LYubmdd1KHkDS38FAEohfMs8VE+4Uyzsv3
         yNerpXehywu24yet4A4sdLjCDe1Biov4aAw1jOcbzlrhJZeLUb1cfN6KXQWNtmBgPtsA
         AzGibCfdVSPfsSMVQeXAYjgICq/zRSBCK9ZBGaOO1WIFL3gTuF1+AaJJUntdoPtG33WT
         TEig==
X-Gm-Message-State: AOAM530hbfVXaD385cKoegzvIK91TInUeWqsqmdwnWVe3h2h6t0g5glM
        l66JZcR7ulG2tJczAAE0E7S5R+60rMo=
X-Google-Smtp-Source: ABdhPJyzxr0dRNy+9whG5CwfrG4sdOKAla1vCkFmfcjMOxrtJEUQ2Vgi9Md+HNsHQ6Nas5i0OwoeBQ==
X-Received: by 2002:a05:6102:41b:: with SMTP id d27mr11923557vsq.197.1591990442138;
        Fri, 12 Jun 2020 12:34:02 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id t76sm1086987vkt.56.2020.06.12.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:34:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth: Fix op_code size entry from the previous patch
Date:   Fri, 12 Jun 2020 19:33:58 +0000
Message-Id: <20200612193358.203186-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The previous applied patch introduced an error that was not present in
the submitted patch here: https://patchwork.kernel.org/patch/11599123/

In particular MGMT_SET_DEF_SYSTEM_CONFIG_SIZE was introduced but
MGMT_SET_DEF_SYSTEM_CONFIG was used.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2e0f976e7e04..99fbfd467d04 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7303,7 +7303,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_HDEV_OPTIONAL },
 	{ read_def_system_config,  MGMT_READ_DEF_SYSTEM_CONFIG_SIZE,
 						HCI_MGMT_UNTRUSTED },
-	{ set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG,
+	{ set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG_SIZE,
 						HCI_MGMT_VAR_LEN },
 };
 
-- 
2.27.0.290.gba653c62da-goog


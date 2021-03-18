Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AC064D74
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 20:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCRUq6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCRUqm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 16:46:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02AC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 13:46:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso5583928pji.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPmrbYDotqOxaSlH5cYbrsimCz1eUvQO5ZZXQ7KnjtQ=;
        b=AMIn4zwiT9KiJ8cUkl4sGodmtamRtqSaABB/DgbCup7zFxXV7shSxaOSwPoFIeG9gM
         7qa1/pgznVxwd8E/exXzDmx8n6jNyIwaykr5UoX9PwWEuSt+iRiYl0JPXmJcvgGPYpej
         8vRx2b+ALHO7s+5r1MA/lS1E7nA5bbZfKP3nlrTBY5+QNDEv1oqOJ2Y3ZhelyNM1dket
         uHwhBWLKNmUqCFU1vNgv3h2GDBY0xfKwY0HwjTC77ccW2E1dAlmZDLoEh2IFwudzvNhC
         lQAyHRjd24uGL298AoxF6io+qoLmRgAzWmVVYenu0pw80EXnRRzSzYbjHz/1on42FYjV
         nb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPmrbYDotqOxaSlH5cYbrsimCz1eUvQO5ZZXQ7KnjtQ=;
        b=Z3a0adgahkpxceBTuMO1+PWrZ0QEyU83aTFV0RWSHshqHDy8syfq0uvSMgUvQQSmdP
         Uhkq2ZUkotneBuVPxuHOmhWsFtGB7yudDngtUMzAFS5Rna7S7K7kBQRkhHTDZYz2Rm6o
         jmX8iBgh2R3gKV0x6W6hGiBIS48uajObOXUVpkScLJUebjJ2FxkSfksSkBoJE1AJqbcn
         JwehS4iS3HEjemDA8FZ0ID3QaELow7/7IjytqPke34M4VMIr33BrZSRV2EuHPKg0ZVMS
         ateAR5JNHPCduf5BbQSE+xUUdmfgqr3Fubhkfhk8Ql+d3XpBXrMmuO/VhM1bpjdpLkUq
         rU8w==
X-Gm-Message-State: AOAM532dTtcthEgr0tPiRKpMBwbvtiHNP8psWPIwWN0J4owQ6ByDGvgX
        AjQJdIiXjAc/muvaYTifzIrHXVh+Gp0=
X-Google-Smtp-Source: ABdhPJwbs6K17pc7gT0WQVm6jA8jS3+NQgrLMv1aHSSZbytDgVmyxt4dZs6go9ql6gD4Lad/Y89FOA==
X-Received: by 2002:a17:90a:1049:: with SMTP id y9mr6106720pjd.173.1616100401607;
        Thu, 18 Mar 2021 13:46:41 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:30fa:1859:1934:aec6])
        by smtp.gmail.com with ESMTPSA id nk3sm3222097pjb.17.2021.03.18.13.46.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:46:41 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: [BlueZ v2] tools/mgmt-tester: Fix for scan response in read adv feature command
Date:   Thu, 18 Mar 2021 13:46:40 -0700
Message-Id: <20210318204640.424409-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the test failure with the read advertising feature
API which is changed to include the scan response flag.

 Read Advertising Features - Success 1 (No instance) 	Failed
 Read Advertising Features - Success 2 (One instance)	Failed
 Read Ext Advertising Features - Success 3 (PHY flags)	Failed
---
 tools/mgmt-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bb9fb0b9c..1835ca079 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4162,7 +4162,7 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 };
 
 static const uint8_t read_adv_features_rsp_1[] =  {
-	0x7f, 0xf0, 0x00, 0x00,	/* supported flags */
+	0x7f, 0xf0, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -4177,7 +4177,7 @@ static const struct generic_data read_adv_features_success_1 = {
 };
 
 static const uint8_t read_adv_features_rsp_2[] =  {
-	0x7f, 0xf0, 0x00, 0x00,	/* supported flags */
+	0x7f, 0xf0, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -7137,7 +7137,7 @@ static const struct generic_data set_appearance_success = {
 };
 
 static const uint8_t read_adv_features_rsp_3[] =  {
-	0xff, 0xff, 0x00, 0x00,	/* supported flags */
+	0xff, 0xff, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x01,			/* max_instances */
-- 
2.25.1


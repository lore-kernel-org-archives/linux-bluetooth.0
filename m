Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E29C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1571C60F94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 16:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhJFQe0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFQeY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 12:34:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7279C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 09:32:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a11so2079067plm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJCrmKzaquOf9OCImM/cjgpddQski2yw2AhR0ZSW0c8=;
        b=Negw7wxRX1bCSK6M0G36UbPYMHp3zm/y2Y1Ba9/Pe3JWgvHAnAzcw04C3T6YjofJpF
         wDiiDhRBzUGgbakQnB253H4F3huan9F4/0R1mGO3rQqiTdLaXtOVgMn8bcRLjHwlTk82
         5Z7AiE0n6TfaO/9ExVvayKzpNe8p18Sz3KQ0xKqfCWKv5kqw0T1MOhsj32t9pWueWwgb
         VLiGbjrb/C0bsi5PPl1rOXQUM75vzsv6PdSUdKLQKTzwwFLjH4UMywPGcVZN/fjgM0wQ
         Upzn+H4N61k1bZMw37PI1yTfY0hVGbpkL58JCNlXOhGCjkjJJPUocOIfr7hjSY1Xf0FD
         gx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJCrmKzaquOf9OCImM/cjgpddQski2yw2AhR0ZSW0c8=;
        b=BGp3JX7W5o/P+uJeQtigin/lsUgU5Ztmbndb33n/baILtXi8IhELCPfWeWQck+wnji
         xUck5ddyXN2JjjmHbis06y+eo8x21MNl3zY3bQJNmeCS/kQaF1SstEMB1oZaLoaJzbSD
         eTSA4jtkTSwYTfEveJv0X39eoVzgDqV0I9dw4TwVDlpUy5LVAKGb57Jqz3pUeOrWJyZx
         PCUfjyQSGHIqSQqwmaPc27cynswpOtIsiMOXCAmFsPhPxe7BlJOBo+VNWfkpYHynpYN2
         x4YuNo11owPMuDRtaNiBVVeB6LCSUj1ksglncFRGFXNrqbxTIpNISAhB9f66tkLFh4gP
         bIng==
X-Gm-Message-State: AOAM530Gmq3KtRx7Z3XqDTmPhRA6MCKOcmb+qjaIktG11hYpzv0v8Qa7
        6oUwLv8oSc62VsrGwg2njtAla5Vuyo4kUA==
X-Google-Smtp-Source: ABdhPJyF6ymJnZwhph/NXOl6cycQXa1i4tkuKc/pe3hd+Ax18hIaAhK8PER/CGxRoqex9rFXaHeLbA==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr12141810pjw.140.1633537951863;
        Wed, 06 Oct 2021 09:32:31 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:8e4c:2d64:6206:9120])
        by smtp.gmail.com with ESMTPSA id s2sm20871506pfe.215.2021.10.06.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:32:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2] Bluetooth: mgmt: Fix Experimental Feature Changed event
Date:   Wed,  6 Oct 2021 09:32:28 -0700
Message-Id: <20211006163228.154401-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the controller index in the Experimental Features
Changed event for the offload_codec and the quality_report features to
use the actual hdev index instead of non-controller index(0xffff) so the
client can receive the event and know which controller the event is for.

Fixes: 9332efdf02e9 ("Bluetooth: Add offload feature under experimental flag")
Fixes: 50a75f15531a ("Bluetooth: Support the quality report events")

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/mgmt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e5283607b97..44683443300c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3927,7 +3927,9 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
 }
 #endif
 
-static int exp_quality_report_feature_changed(bool enabled, struct sock *skip)
+static int exp_quality_report_feature_changed(bool enabled,
+					      struct hci_dev *hdev,
+					      struct sock *skip)
 {
 	struct mgmt_ev_exp_feature_changed ev;
 
@@ -3935,7 +3937,7 @@ static int exp_quality_report_feature_changed(bool enabled, struct sock *skip)
 	memcpy(ev.uuid, quality_report_uuid, 16);
 	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
 
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
 				  &ev, sizeof(ev),
 				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
 }
@@ -4156,14 +4158,15 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 				&rp, sizeof(rp));
 
 	if (changed)
-		exp_quality_report_feature_changed(val, sk);
+		exp_quality_report_feature_changed(val, hdev, sk);
 
 unlock_quality_report:
 	hci_req_sync_unlock(hdev);
 	return err;
 }
 
-static int exp_offload_codec_feature_changed(bool enabled, struct sock *skip)
+static int exp_offload_codec_feature_changed(bool enabled, struct hci_dev *hdev,
+					     struct sock *skip)
 {
 	struct mgmt_ev_exp_feature_changed ev;
 
@@ -4171,7 +4174,7 @@ static int exp_offload_codec_feature_changed(bool enabled, struct sock *skip)
 	memcpy(ev.uuid, offload_codecs_uuid, 16);
 	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
 
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
+	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
 				  &ev, sizeof(ev),
 				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
 }
@@ -4229,7 +4232,7 @@ static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 				&rp, sizeof(rp));
 
 	if (changed)
-		exp_offload_codec_feature_changed(val, sk);
+		exp_offload_codec_feature_changed(val, hdev, sk);
 
 	return err;
 }
-- 
2.25.1


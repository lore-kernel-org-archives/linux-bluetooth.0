Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0B76120F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 00:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJFAxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 20:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhJFAw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 20:52:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE773C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 17:51:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so977955pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AJNHjUwYYwrWBM5+4BiDPzTx25ECd3t4lmtori7faY=;
        b=A2hjdPbm0unNe66NDzxpHJGGX/UXhd4EeOPSKGfTLIpmmlLxoF+iCw6Pjv6iBMpf+K
         XPxpu9opP+n0hNQCM6pfY0GVrF/7AF2TOInpSFUhJGQSpWViYYicksWeaQ4YMnIdE+ws
         RB8FxQm5RuNHmpl/eP+EZ+ZB3SaB6dMDImWoVRUg33Q7wjgc8crEkNPtLSZGOM0Z63++
         7MD2sjNDPEIqAHM8csY1dkhDC1B1GS6sbXUrY8VtaePTnzosUSmXTewMbsRHFixuLzf8
         WjE43eTc/LGB4GLF3/jSVDmAhPZGfvUt2bGRDEx2mrRk5WPOJo2g+gst6xn3Fld58DU9
         BGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AJNHjUwYYwrWBM5+4BiDPzTx25ECd3t4lmtori7faY=;
        b=SPdLHIAQyGiCFTvLs3yKvy1+CAmujw11obK1Sgj/FSwgV3E/0xJNLVUgYWvWt/EF6T
         RtS700VRwD2/waT1WguRg064EsDVMdQX6ai4pjq/HOBb4oh32GhLvuwxJkLowWN1P3In
         RVXUD6wsQbmqrW0XtRo654IRDjvJjp0dTdI+c0OsG1fFUvGT5+yVun3f1Ux3vBfF0tP/
         RwtPMEFKqKSIFdEurwG0mwSaVugVXD+NMpD9cOhUw678hhjcJ8G1NEIJLNWzIFb11jgQ
         Jbht8Hqev/lv5CSssEmncDrLbJ6Jx7paUUccvAszc8EdtkJXwlQ3xSaOATDJ7XxSb0/g
         2iKA==
X-Gm-Message-State: AOAM533fjEKcuhgxyBofpq6VLgj6SZrvNSpYEstXYD5hLzD+y2MdTA7i
        b/887Dq1E4MDeF177+hZDbFYO4x5ChE8BA==
X-Google-Smtp-Source: ABdhPJzmRUrFb4nz5n8O90Ir8i612QuaQp8EfdZ0vrCx6Fy4YxVfvgBmY1vPYT6g+T4TWhTv/t77KQ==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr7496818pjb.0.1633481467054;
        Tue, 05 Oct 2021 17:51:07 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:b80e:8aa2:35bc:9d60])
        by smtp.gmail.com with ESMTPSA id j9sm8062842pgn.68.2021.10.05.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:51:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix Experimental Feature Changed event
Date:   Tue,  5 Oct 2021 17:51:04 -0700
Message-Id: <20211006005104.98564-1-hj.tedd.an@gmail.com>
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

